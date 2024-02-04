require "logger"
require "pathname"

class App < Roda
  configure do
    logger = ::Logger.new(File.open(Pathname.new(opts[:root_dir] + "./logs/#{self.environment.to_s}.log"), "a"))
    logger.level = ::Logger::DEBUG if development?
    opts[:logger] = logger
  end
end
