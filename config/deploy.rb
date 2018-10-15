require 'mina/git'
# require 'mina/bundler'
require 'mina/rbenv'  # for rbenv support. (https://rbenv.org)
require 'mina/deploy'

set :application_name, 'rubyee'
set :domain, 'gl'
set :deploy_to, '$HOME/rubyee'
set :repository, 'https://github.com/priit/rubyee.git'
set :branch, 'master'

task :pr do
  # honor pr command
end

task :remote_environment do
  invoke :'rbenv:load'
end

task setup: :remote_environment do
  deploy do
    invoke :'git:clone'
  end
end

desc "Deploys the current version to the server."
task deploy: :remote_environment do
  deploy do
    # bundle exec middleman build
    invoke :'git:clone'
  end
end
