require "roda"
require "pathname"

class App < Roda

  # https://roda.jeremyevans.net/rdoc/classes/Roda/RodaPlugins/Environments.html
  plugin :environments

  require_relative './configs/setting.config'
  require_relative './configs/server.config'
  require_relative './configs/logger.config'
  require_relative './configs/database.config'
  require_relative './configs/connect_sequel.config'

  # https://roda.jeremyevans.net/rdoc/classes/Roda/RodaPlugins/AllVerbs.html
  plugin :all_verbs

  # https://roda.jeremyevans.net/rdoc/classes/Roda/RodaPlugins/CommonLogger.html
  plugin :common_logger,  opts[:logger]

  # https://roda.jeremyevans.net/rdoc/classes/Roda/RodaPlugins/Json.html
  plugin :json

  # https://roda.jeremyevans.net/rdoc/classes/Roda/RodaPlugins/MultiRoute.html
  plugin :multi_route
  # # https://roda.jeremyevans.net/rdoc/classes/Roda/RodaPlugins/HashBranchViewSubdir.html
  # plugin :hash_branch_view_subdir

  # https://roda.jeremyevans.net/rdoc/classes/Roda/RodaPlugins/Public.html
  plugin :public

  # https://roda.jeremyevans.net/rdoc/classes/Roda/RodaPlugins/Render.html
  plugin :render

  # # https://roda.jeremyevans.net/rdoc/classes/Roda/RodaPlugins/DefaultHeaders.html
  # plugin :default_headers,
  #   'Content-Type'=>'text/html',
  #   'Strict-Transport-Security'=>'max-age=63072000; includeSubDomains',
  #   'X-Content-Type-Options'=>'nosniff',
  #   'X-Frame-Options'=>'deny'

  # # https://roda.jeremyevans.net/rdoc/classes/Roda/RodaPlugins/ContentSecurityPolicy.html
  # plugin :content_security_policy do |csp|
  #   csp.default_src :none # deny everything by default
  #   csp.style_src :self
  #   csp.script_src :self
  #   csp.connect_src :self
  #   csp.img_src :self
  #   csp.font_src :self
  #   csp.form_action :self
  #   csp.base_uri :none
  #   csp.frame_ancestors :none
  #   csp.block_all_mixed_content
  #   csp.report_uri 'CSP_REPORT_URI'
  # end

  # # https://roda.jeremyevans.net/rdoc/classes/Roda/RodaPlugins/RouteCsrf.html
  # plugin :route_csrf


  route do |r|
    r.public
  end
end
