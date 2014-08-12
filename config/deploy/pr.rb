desc 'Deploy'
task :deploy do
  on 'glrubyee' do 
    puts `bundle exec middleman build`
    upload!('build', '/home/rubyee/rubyee/site-uploaded', :via => :scp, :recursive => true)
    execute 'rm /home/rubyee/rubyee/site-old -rf && mv /home/rubyee/rubyee/site /home/rubyee/rubyee/site-old -f'
    execute 'mv /home/rubyee/rubyee/site-uploaded /home/rubyee/rubyee/site'
    puts `rm build -rf`
  end
end
