# frozen_string_literal: true

namespace :solr do
  desc 'Push the new solr configs to the server'
  task :update_config do
    on roles :app do
      run 'cp solr/conf/* /var/solr/data/cores/hyrax/production/'
    end
  end

  desc 'Restart solr'
  task :restart do
    on roles :app do
      run "#{sudo} systemctl restart solr.service"
    end
  end

  desc 'Reindex the collection'
  task :reindex do
    on roles :app do
      run "cd #{current_path} && RAILS_ENV=production bundle exec solr:reindex"
    end
  end

  after :update_config, :restart
  after :update_config, :reindex
end
