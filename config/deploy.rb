# config valid only for current version of Capistrano
lock "3.10.1"


set :application, 'temirtulpar_erp'
set :repo_url, 'git@bitbucket.org:spalmalo/temirtulpar_erp.git'

set :deploy_to, "/opt/temirtulpar_erp"
set :rvm_ruby_version, '2.5.1'

append :linked_dirs, 'log', 'tmp', 'public'
append :linked_files, '.env', 'config/puma.rb', 'config/database.yml', 'config/secrets.yml'

set :foreman_init_system, 'systemd'
set :foreman_export_path, '/lib/systemd/system'
set :foreman_options, app: fetch(:application), root: current_path, log: File.join(shared_path, 'log')
set :branch, 'master'
namespace :deploy do
  task :restart do
    on roles(:app) do |host|
      f = "#{fetch :foreman_export_path}/#{fetch(:foreman_options)[:app]}.conf"
      if test("[ -f #{f} ]")
        invoke 'foreman:restart'
      else
        invoke 'foreman:setup'
      end
    end
  end

  desc "Fix file permissions"
  task :fix_file_permissions do
    on roles(:app) do
      execute "chown -R #{fetch(:application)} #{shared_path}/tmp"
      execute "chown -R #{fetch(:application)} #{shared_path}/log"
      execute "chown -R #{fetch(:application)}:root #{shared_path}/public"
    end
  end

  task :check_env do
    on roles(:all) do |host|
      f = "#{shared_path}/.env"
      if test("[ -f #{f} ]")
        info "#{f} already exists on #{host}!"
      else
        execute "echo 'RAILS_ENV=#{fetch :stage}' > #{f}"
        execute "echo 'PATH=/usr/local/rvm/wrappers/#{fetch(:rvm_ruby_version)}:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin' >> #{f}"
      end
    end
  end

  before 'check:linked_files', :check_env
  after :publishing, :fix_file_permissions
  after :publishing, :restart
end

