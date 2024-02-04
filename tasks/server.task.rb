require_relative '../configs/setting.config.rb'

namespace :server do
  desc "Start development server"
  task :dev do
    exec("RACK_ENV=development bundle exec rerun 'rackup -p #{App.opts[:port]} -o #{App.opts[:bind]}'")
  end

  desc "Start production server"
  task :prod do
    exec("RACK_ENV=production bundle exec rackup -p #{App.opts[:port]} -o #{App.opts[:bind]}")
  end
end
