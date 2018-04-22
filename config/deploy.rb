#require 'capistrano/ext/multistage'
# config valid for current version and patch releases of Capistrano
lock "~> 3.10.2"

#set :stages, ["staging", "production"]
#set :default_stage, "production"
set :rvm_type, :system
set :application, "rails-test-app"
#set :repo_url, "git@github.com:jfacow/rails-test-app.git"
set :repo_url, 'https://github.com:443/jfacow/rails-test-app.git'
#set :port, 22
set :bundle_gemfile, -> { release_path.join('Gemfile') }
# Default branch is :master
#ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
#server "206.189.60.152:10022", :app, :web, :db, :primary => true
set :deploy_to, "/home/deploy"
set :user, "deploy"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
#append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
#append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
before "deploy:assets:precompile", "deploy:yarn_install"

namespace :deploy do
  desc 'Run rake yarn:install'
  task :yarn_install do
    on roles(:web) do
      within release_path do
#        execute("cd #{release_path} && yarn install")
         execute("cd #{release_path} && bundle install")
#         execute("bundle install")
         execute("cd #{release_path} && ./bin/yarn add production")
      end
    end
  end
end
