require "sequel"

DB = Sequel.sqlite(File.expand_path("./twindex.db", __dir__))

def load_models
  require_relative "models/twt.rb"
end
