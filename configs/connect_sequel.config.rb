require "sequel"

class App < Roda
  # Base default database
  # https://sequel.jeremyevans.net/rdoc/files/doc/opening_databases_rdoc.html
  DB = Sequel.connect(
    adapter: 'postgres',
    host: opts[:database_host],
    port: opts[:database_port],
    database: opts[:database_name],
    user: opts[:database_user],
    password: opts[:database_password],
    logger: opts[:logger],
  )

  if development?
    DB.sql_log_level = :debug
    # DB.loggers << Logger.new($stdout)
  end

  # JSON/JOSNB support
  # https://sequel.jeremyevans.net/rdoc-plugins/files/lib/sequel/extensions/pg_json_rb.html
  DB.extension :pg_json
  DB.wrap_json_primitives = true

  # JSON/JOSNB operation
  # https://sequel.jeremyevans.net/rdoc-plugins/files/lib/sequel/extensions/pg_json_ops_rb.html
  Sequel.extension :pg_json_ops
end
