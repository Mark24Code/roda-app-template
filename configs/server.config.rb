class App < Roda
  configure do
    opts[:max_threads] = ENV.fetch('APP_MAX_THREADS') { 5 }
  end

  # configure :development do
  # end

  # configure :production do
  # end
end
