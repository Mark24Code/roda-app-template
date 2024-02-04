require 'roda'

class App < Roda
  # https://roda.jeremyevans.net/rdoc/classes/Roda/RodaPlugins/Environments.html
  plugin :environments

  configure do
    opts[:root_dir] = Pathname.new('.')
    opts[:bind] = ENV.fetch('APP_HOST') { '0.0.0.0' }
    opts[:port] = ENV.fetch('APP_PORT') { 9292 }
    opts[:secret] = ENV.fetch('APP_SECRET') { 'YOU CANNT GUESS ME' }
  end

  # configure :development do
  # end

  # configure :production do
  # end
end
