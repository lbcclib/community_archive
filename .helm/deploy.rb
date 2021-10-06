EXPERIMENTAL_OCI = { 'HELM_EXPERIMENTAL_OCI' => '1' }.freeze

# Ruby script to deploy
# Assumes that kubectl and helm are installed, and that kubectl is connected to the correct context

# The following envvars must be defined:
# IMAGE_TAG
# POSTGRESQL_PASSWORD
# REDIS_PASSWORD
# SOLR_PASSWORD

# There are also some optional envvars with sensible defaults:
# HYRAX_HELM_CHART_VERSION
# RELEASE (defaults to staging release, but you may wish to upgrade the production release instead)

def run_helm_command(*args)
  puts "Running helm #{args.join(' ')}"
  system EXPERIMENTAL_OCI, 'helm', *args
end

def hyrax_chart_version
  ENV['HYRAX_HELM_CHART_VERSION'] || '0.22.0'
end

def release
  ENV['RELEASE'] || 'staging'
end

run_helm_command 'pull', 'oci://ghcr.io/samvera/hyrax/hyrax-helm', "--version=#{hyrax_chart_version}", '--untar'
run_helm_command 'dependency', 'update', 'hyrax'
run_helm_command 'upgrade', '--namespace=communityarchive', '--install', '--atomic',
                 "--values=#{__dir__}/values.yml",
                 "--set=image.tag=#{ENV['IMAGE_TAG']}",
                 "--set=worker.image.tag=#{ENV['IMAGE_TAG']}",
                 "--set=postgresql.postgresqlPassword=#{ENV['POSTGRESQL_PASSWORD']}",
                 "--set=redis.password=#{ENV['REDIS_PASSWORD']}",
                 "--set=solr.authentication.adminPassword=#{ENV['SOLR_PASSWORD']}",
                 release, 'hyrax'
