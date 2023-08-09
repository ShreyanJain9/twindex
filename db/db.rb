require "sequel"

DB = Sequel.sqlite(File.expand_path("./twindex.db", __dir__))

def load_models
  require_relative "models/twt.rb"
  require_relative "models/feed.rb"
  require_relative "models/mention.rb"
  require_relative "models/follow.rb"
end
