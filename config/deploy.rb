set :application, "Nezabudem.NET"
set :repo_url, "git@bitbucket.org:hazg/nezabudem.net.git"
set :keep_releases, 1
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

 set :deploy_to, '/var/www/webmaster/data/www_rails3/nezabudem.net'
 set :scm, :git

set :format, :pretty
# set :log_level, :debug
# set :pty, true

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/i public/images public/javascripts public/uploads}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end
  
  desc "Symlinks public/uploads"
  task :symlink_uploads do
    run "ln -s #{deploy_to}/shared/public/* #{release_path}/public/"
  end


  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      #within release_path do
        #execute :rake, 'cache:clear'
      #end
    end
  end

  after :finishing, 'deploy:cleanup'

end
