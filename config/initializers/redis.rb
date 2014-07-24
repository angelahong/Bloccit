redis_conf = YAML::load(File.read(Rails.root.join("config", "redis.yml")))[Rails.env]
defaults = YAML::load(File.read(Rails.root.join("config", "redis.yml")))["default"]
REDIS = Redis.new(defaults.merge(redis_conf))
