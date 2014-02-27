require "rvm/capistrano" 
set :rvm_ruby_string, '2.0.0' 

role :app, 'oldgitlab'
set :repository, 'https://github.com/priit/rubyee.git'

set :use_sudo, false
set :branch, 'pr'
set :deploy_to, '/var/apps/rubyee/'
set :scm, :git
set :scm_verbose, true
set :deploy_via, :remote_cache
set :bundle_flags, '--deployment'

set :application, 'Rubyee static'
 
# Override default tasks which are not relevant to a non-rails app.
namespace :deploy do
  task :migrate do
    #puts "Skipping migrate."
  end

  task :finalize_update do
    #puts "Skipping finalize_update."
  end

  task :start do
    #puts "Skipping start."
  end

  task :stop do
    #puts "Skipping stop."
  end

  task :restart do
    #puts "Skipping restart."
  end

  task :precompile do
    run "cd #{release_path} && bundle exec middleman build"  
  end
end

namespace :bundle do
  task :install do
    run "cd #{release_path} && bundle install --path #{shared_path}/bundle --deployment --without development test"
  end
end

# leave only 5 releases
after "deploy", "deploy:cleanup"


# =============================================================================
# SERVER RESTART
# =============================================================================

namespace :deploy do
  task :restart, :roles => :app do
    sudo "/etc/init.d/nginx reload"
  end
end
