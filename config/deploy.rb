require 'thinking_sphinx/deploy/capistrano'

set :application, "Nezabudem.NET"
set :repository,  "git@bitbucket.org:hazg/nezabudem.net.git"

set :user,        'www-data'
set :host,        'nezabudem.net'


set :scm, :git

set :deploy_to, '/var/www/webmaster/data/www_rails3/nezabudem.net'
set :use_sudo, false

#set :scm, :subversion
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :domain, 'www-data@nezabudem.net'
role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run

set :keep_releases, 1

after 'deploy:update_code', 'deploy:symlink_db'
after 'deploy:symlink_db', 'symlink_uploads'
after 'deploy:start', 'deploy:cleanup'

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts
namespace :deploy do
  desc "Symlinks public/uploads"
  task :symlink_uploads, :roles => :app do
    run "ln -s #{deploy_to}/shared/public/uploads #{release_path}/public/"
  end
end


# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts
namespace :deploy do
  desc "Symlinks the database.yml"
  task :symlink_db, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  end
end


# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :assets do task :update_asset_mtimes do ; end end

load 'deploy/assets'


namespace :deploy do
  namespace :assets do
    desc 'Run the precompile task locally and rsync with shared'
    task :precompile, :roles => :web, :except => { :no_release => true } do
      %x{bundle exec rake assets:precompile RAILS_ENV=production}
      %x{rsync --recursive --times --rsh=ssh --compress --human-readable --progress public/assets #{user}@#{host}:#{shared_path}}
      %x{bundle exec rake assets:clean}
    end
  end
end
