class SampleMiddleware < Roda
  # https://roda.jeremyevans.net/rdoc/classes/Roda/RodaPlugins/Middleware.html
  plugin :middleware, {:next_if_not_found => true}

  route do |r|
    r.is "mid" do
      "Mid"
    end
  end
end
