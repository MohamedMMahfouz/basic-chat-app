namespace :db do
  desc 'Check if db exists'
  task :exists do
    Rake::Task['environment'].invoke
    ActiveRecord::Base.connection
  rescue
    exit 1
  else
    exit 0
  end
end
