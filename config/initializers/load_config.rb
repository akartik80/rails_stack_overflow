CONFIG_PATH = "#{Rails.root}/config/config.yml".freeze
APP_CONFIG = YAML.load_file(CONFIG_PATH)[Rails.env]
