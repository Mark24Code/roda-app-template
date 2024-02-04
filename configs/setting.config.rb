class App < Roda
  configure do
    opts[:root_dir] = Pathname.new('.')
    opts[:bind] = ENV.fetch('APP_HOST') { '0.0.0.0' }
    opts[:port] = ENV.fetch('APP_PORT') { 4567 }
    opts[:secret] = ENV.fetch('APP_SECRET') { 'YOU CANNT GUESS ME' }
  end

  # configure :development do
  # end

  # configure :production do
  # end
end
