# frozen_string_literal: true

DEFAULT_HYRAX_HELM_CHART_VERSION = '1.0.0'
EXPERIMENTAL_OCI = { 'HELM_EXPERIMENTAL_OCI' => '1' }.freeze

require 'securerandom'
require 'thor'

# CLI for deploying CommunityArchive@LBCC to kubernetes via helm
class DeployToKubernetes < Thor
  desc 'install COMMARCH_VERSION [RELEASE_NAME] [HYRAX_HELM_CHART_VERSION]',
       'install a new helm release (such as a new staging or testing environment)'
  def install(commarch_version, release_name = 'staging', hyrax_helm_chart_version = DEFAULT_HYRAX_HELM_CHART_VERSION)
    pull_and_update_charts hyrax_helm_chart_version
    create_kubernetes_secret
    run_helm_command 'install', *basic_install_flags(release_name, commarch_version),
                     release_name, 'hyrax'
  end

  desc 'upgrade COMMARCH_VERSION [RELEASE_NAME] [HYRAX_HELM_CHART_VERSION]',
       'upgrade the given release (defaults to staging) to the requested version (commit hash)'
  def upgrade(commarch_version, release_name = 'staging', hyrax_helm_chart_version = DEFAULT_HYRAX_HELM_CHART_VERSION)
    pull_and_update_charts hyrax_helm_chart_version
    run_helm_command 'upgrade', *basic_upgrade_flags(release_name, commarch_version),
                     release_name, 'hyrax'
  end

  desc 'pull_and_update_charts [HYRAX_HELM_CHART_VERSION]', 'pulls the hyrax charts, then updates dependencies'
  def pull_and_update_charts(hyrax_helm_chart_version = DEFAULT_HYRAX_HELM_CHART_VERSION)
    run_helm_command 'pull',
                     'oci://ghcr.io/samvera/hyrax/hyrax-helm',
                     "--version=#{hyrax_helm_chart_version}",
                     '--untar'
    run_helm_command 'dependency', 'update', 'hyrax'
  end

  desc 'delete [RELEASE_NAME]', 'provides instructions to delete the requested release (defaults to staging'
  def delete(release_name = 'staging')
    puts "\nWARNING: These commands will take the site down and delete all data!"
    puts "\nhelm uninstall -n communityarchive #{release_name}"
    puts "kubectl delete pvc,pv,pod,svc --selector=app.kubernetes.io/instance=#{release_name}"\
         ' --namespace communityarchive'
  end

  private

  def create_kubernetes_secret
    system 'kubectl create secret generic prod-secrets --namespace communityarchive'\
           " --from-env-file=#{__dir__}/../.env.production"
  end

  def update_kubernetes_secret
    system 'kubectl delete secret prod-secrets --namespace communityarchive --ignore-not-found'
    create_kubernetes_secret
  end

  def basic_install_flags(release_name, commarch_version)
    postgresql_password = new_password
    flags = basic_flags_for_install_and_upgrade(release_name, commarch_version)
    flags << "--set=postgresql.postgresqlPassword=#{postgresql_password}"
    flags << "--set=global.postgresql.postgresqlPassword=#{postgresql_password}"
    flags << "--set=redis.password=#{new_password}"
    flags << "--set=solr.authentication.adminPassword=#{new_password}"
    flags << '--set=skipDbMigrateSeed=true' # Don't install DB, so that it can be created with pg_restore instead
  end

  def basic_upgrade_flags(release_name, commarch_version)
    flags = basic_flags_for_install_and_upgrade(release_name, commarch_version)
    flags << '--atomic'
    flags << '--reuse-values'
    flags << '--set=skipDbMigrateSeed=false' # Run db migrations on upgrade
  end

  def basic_flags_for_install_and_upgrade(release_name, commarch_version)
    flags = values_files(release_name)
    flags << '--namespace=communityarchive'
    flags << "--set=image.tag=#{commarch_version}"
    flags << "--set=worker.image.tag=#{commarch_version}"
  end

  def new_password
    SecureRandom.hex(42)
  end

  def run_helm_command(*args)
    # puts "Running helm #{args.join(' ')}"
    system EXPERIMENTAL_OCI, 'helm', *args
  end

  def values_files(release_name)
    options = ["--values=#{values_file_path}"]
    options << "--values=#{values_file_path(release_name)}" if File.exist? values_file_path(release_name)
    options
  end

  def values_file_path(name = 'values')
    "#{__dir__}/#{name}.yml"
  end
end

DeployToKubernetes.start(ARGV)
