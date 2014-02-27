desc 'Deploy'
task :deploy do
  on 'rubyee' do 
    puts `bundle exec middleman build`
    upload!('build', '/var/apps/rubyee/site-uploaded', :via => :scp, :recursive => true)
    execute 'rm /var/apps/rubyee/site-old -rf && mv /var/apps/rubyee/site /var/apps/rubyee/site-old -f'
    execute 'mv /var/apps/rubyee/site-uploaded /var/apps/rubyee/site'
    puts `rm build -rf`
  end
end
