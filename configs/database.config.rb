class App < Roda

  configure do
    opts[:database_host]= ENV.fetch('DATABASE_HOST')
    opts[:database_port]= ENV.fetch('DATABASE_PORT')
    opts[:database_name]= ENV.fetch('DATABASE_NAME')
    opts[:database_user]= ENV.fetch('DATABASE_USER')
    opts[:database_password]= ENV.fetch('DATABASE_PASSWORD')
  end

  # configure :development do
  # end

  # configure :production do
  # end
end
