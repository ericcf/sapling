set :application, "Sapling"
set :repository,  "git@github.com:ericcf/Sapling.git"

set :scm, :git

role :web, "10.101.8.76"                          # Your HTTP server, Apache/etc
role :app, "10.101.8.76"                          # This may be the same as your `Web` server
role :db,  "10.101.8.76", :primary => true        # This is where Rails migrations will run

ssh_options[:forward_agent] = true

set :branch, "master"

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end