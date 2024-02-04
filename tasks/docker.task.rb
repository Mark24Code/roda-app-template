require_relative '../configs/setting.config.rb'

namespace :docker do
  APP_NAME = "app"

  def get_label(version)
    "#{APP_NAME}:#{version}"
  end

  def build_docker(label_name)
    system("docker build -t #{label_name} .")
  end

  desc 'Build Docker Image'
  task :build, [:version] do |t, args|
    version = args[:version]
    label_name = get_label(version)
    puts "Your docker image version:"
    puts label_name
    build_docker(label_name)
  end

  desc 'Push Docker'
  task :push, [:version] do |t, args|
    puts "[Message] Before run, you need login"
    version = args[:version]

    label_name = get_label(version)
    puts "Your docker image version:"
    puts label_name
    build_docker(label_name)
    system("docker push #{label_name}")
  end

  desc 'Run Docker'
  task :run, [:version] do |t, args|
    puts "[Message] Before run, you need login"
    port = App.opts[:port]
    puts port
    version = args[:version]
    label_name = get_label(version)
    cmd = <<-CMD
    docker run  \
    --net=host \
    --env DATABASE_HOST=$DATABASE_HOST \
    --env DATABASE_PORT=$DATABASE_PORT \
    --env DATABASE_NAME=$DATABASE_NAME \
    --env DATABASE_USER=$DATABASE_USER \
    --env DATABASE_PASSWORD=$DATABASE_NAME \
    -p #{port}:#{port} \
    -it #{label_name}
    CMD
    system(cmd)
  end
end
