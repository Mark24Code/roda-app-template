require "roda"

class App < Roda
  plugin :json
  plugin :hash_routes

  # load all routes
  # path must be root dir -- app
  Dir['app/routes/**/*.route.rb'].each do |file|
    load file
  end

  route do |r|
    r.root do
      { status: 200,
        message: 'hello world'
      }
    end

    r.is "routes" do
      self.class.opts
    end

    # arrange routes dispatch to different namespace
    r.on "sample" do
      r.hash_routes("sample")
    end
  end
end