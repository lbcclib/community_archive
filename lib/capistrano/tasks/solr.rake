# frozen_string_literal: true

namespace :solr do
  desc 'Push the new solr configs to the server'
  task :update_config do
    on roles :app do
      execute :sudo, "cp #{current_path}/solr/conf/* /var/solr/data/cores/hyrax/production/"
    end
  end

  desc 'Restart solr'
  task :restart do
    on roles :app do
      execute :sudo, 'systemctl restart solr.service'
    end
  end

  desc 'Reindex the collection'
  task :reindex do
    on roles :app do
      execute "cd #{current_path} && RAILS_ENV=production bundle exec rake solr:reindex"
    end
  end

  after :update_config, :restart
  after :update_config, :reindex
end
