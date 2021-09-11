require_relative './prepare'

module Tools
  def self.get_config(config_filepath, filter=nil)
    require 'erb'
    require 'yaml'

    doc = ERB.new(File.read(config_filepath)).result
    config = YAML.load(doc)

    if filter
      config[filter]
    else
      config
    end
  end

  def self.default_config
    default_config_path = File.expand_path(File.join($PROJECT_DIR, 'config.yml'))
    Tools::get_config(default_config_path, $APP_ENV)
  end

  def self.app_config(app_config_path = 'config.yml')
 
    default_config_path = File.expand_path(File.join($PROJECT_DIR, 'config.yml'))
    default_config = Tools::get_config(default_config_path, $APP_ENV)

    app_config_abs_path = File.expand_path(File.join($PROJECT_DIR, app_config_path))
    app_config = Tools::get_config(app_config_abs_path, $APP_ENV)

    {}.merge(default_config, app_config)
  end

  def self.db_config(db_config_path = 'database.yml')

    db_config_abs_path = File.expand_path(File.join($PROJECT_DIR, db_config_path))
    db_config = Tools::get_config(db_config_abs_path, $APP_ENV)

    {}.merge(db_config)
  end


  def self.require_mods_from_dir(dir_path)
    mods = Dir["#{dir_path}/**/*.rb"]
    mods.each do |mod|
      require mod
    end
  end

  def self.load_mods(dir_name)
    dir_path = File.expand_path(File.join($PROJECT_DIR, dir_name))
    Tools::require_mods_from_dir(dir_path)
  end
end