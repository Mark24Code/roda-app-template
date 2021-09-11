require 'sequel'
require 'tools'
require 'log/base_logger'

namespace :db do
  
  MIGRATIONS_DIR = 'db/migrations'
  IS_DEVELOPMENT = $APP_ENV == 'development'
  DATABASE_CONFIG = Tools::db_config('config/base_database.yml')
  DATABASE_URL = DATABASE_CONFIG['database_url']

  desc "Connect database"
  task :connect do
    Sequel.extension :migration
    DB = Sequel.connect(DATABASE_URL, logger: $LOGGER )
  end


  desc "Create database"
  task :create,[:database_name] do | t, args |
    db_name = args[:database_name]
    puts "CREATEDB: #{db_name}"
    system("createdb #{db_name}")
  end

  desc "Drop database"
  task :drop, [:database_name] do |t, args |
    db_name = args[:database_name]
    puts "DROPDB: #{db_name}"
    system("dropdb #{db_name}")
  end

  desc "Create a migration"
  task :create_migration, [:name] => :connect do |t, args|
    raise("Name required") unless args[:name]

    # http://sequel.jeremyevans.net/rdoc/files/doc/migration_rdoc.html#label-TimestampMigrator+Filenames
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    migration_path = File.expand_path(File.join($PROJECT_DIR,"db","migrations","#{timestamp}_#{args[:name]}.rb"))

    File.open(migration_path,"w") do |f|
      f.write(<<-MIGRATION_TEMPLATE
# Help Doc Sequel Migrations & Schema
# http://sequel.jeremyevans.net/rdoc/files/doc/migration_rdoc.html
# http://sequel.jeremyevans.net/rdoc/files/doc/schema_modification_rdoc.html
Sequel.migration do  

  # change do
  
  # end


  # up do

  # end


  # down do

  # end

end
MIGRATION_TEMPLATE
)
    end

    puts "MIGRATION CREATED:"
    puts "#{path}"
  end


  # http://sequel.jeremyevans.net/rdoc/files/doc/migration_rdoc.html#label-Running+migrations
  desc "Run migrations"
  task :migrate, [:version] => :connect do |t, args|
    if args[:version]
      Sequel::Migrator.run(DB, MIGRATIONS_DIR, target: args[:version].to_i)
    else
      Sequel::Migrator.run(DB, MIGRATIONS_DIR)
    end


    if IS_DEVELOPMENT
      # http://sequel.jeremyevans.net/rdoc/files/doc/migration_rdoc.html#label-Dumping+the+current+schema+as+a+migration
      # -d ruby style
      # system("sequel -d #{DATABASE_URL} > #{MIGRATIONS_DIR}/schema.rb")
      # # -D database style
      system("sequel -D #{DATABASE_URL} > #{MIGRATIONS_DIR}/schema.rb")
    end

    Rake::Task["db:version"].execute
  end


  desc "Checking for current migrations"
  task :check => :connect do
    puts "DB Check: if migration is update:"
    puts Sequel::Migrator.is_current?(DB, MIGRATIONS_DIR)
  end


  # http://sequel.jeremyevans.net/rdoc/files/doc/migration_rdoc.html#label-Running+migrations
  desc "Rollback to migration"
  task :rollback, [:version]  => :connect do |t|
    version = if DB.tables.include?(:schema_migrations)
                previous = DB[:schema_migrations].order(Sequel.desc(:filename)).limit(2).all[1]
                previous ? previous[:filename].split("_").first : nil
              end || 0

    Sequel::Migrator.run(DB, MIGRATIONS_DIR, target: version.to_i)

    if IS_DEVELOPMENT
      system("sequel -d #{DATABASEDATABASE_URL_URL} > #{db_dir}/schema.rb")
    end

    Rake::Task["db:version"].execute
  end


  desc "Prints current schema version"
  task :version => :connect do    
    filename = if DB.tables.include?(:schema_migrations)
      DB[:schema_migrations].order(Sequel.desc(:filename)).first[:filename]
    end || 0

    version, rest = filename.split('_')
    puts "Schema Version: #{version}"
    puts "Migration: #{filename}"
  end

  desc "List database tables"
  task :ls => :connect do    
    system("sequel -c 'p DB.tables' #{DATABASE_URL}")
  end

  # https://github.com/jeremyevans/sequel/blob/master/doc/bin_sequel.rdoc#label-Not+Just+an+IRB+shell
  desc "Database Console"
  task :console => :connect do    
    puts "Sequel Console:"
    system("sequel #{DATABASE_URL}")
  end
end
