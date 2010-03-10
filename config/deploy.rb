set :application, "Sapling"
set :repository,  "git@github.com:ericcf/sapling.git"

set :scm, :git

role :web, ""                          # Your HTTP server, Apache/etc
role :app, ""                          # This may be the same as your `Web` server
role :db,  "", :primary => true        # This is where Rails migrations will run

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