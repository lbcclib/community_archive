# config valid only for current version of Capistrano
lock "3.9.1"

set :application, "hyrax"
set :repo_url, "https://github.com/lbcclib/community_archive.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, ".env", ".env.beta", ".env.production" 

# Default value for linked_dirs is []
append :linked_dirs, "log", "public/assets", "public/system", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :bundle do
  desc "run bundle install and ensure all gem requirements are met"
  task :install do
    run "cd #{current_path} && bundle install  --without=test --no-update-sources"
  end
end

before "deploy:restart", "bundle:install"
