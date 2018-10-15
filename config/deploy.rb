require 'mina/bundler'
require 'mina/git'
require 'mina/rbenv'  # for rbenv support. (http://rbenv.org)

set :domain, 'gl'
set :deploy_to, '$HOME/rubyee'
set :repository, 'https://github.com/priit/rubyee.git'
set :branch, 'master'

task :pr do
  # honor pr command
end

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  invoke :'rbenv:load'
end

task setup: :environment do
  deploy do
    invoke :'git:clone'
    queue! 'gem install bundler'
    invoke :'bundle:install'
  end
end

desc "Deploys the current version to the server."
task deploy: :environment do
  deploy do
    invoke :'git:clone'
    invoke :'bundle:install'
    invoke :'middleman:build'
  end
end

task :'middleman:build' do
  command %{
    echo "-----> Building site"
    #{echo_cmd %[bundle exec middleman build]}
    #{echo_cmd %[mv build public]}
  }
end
