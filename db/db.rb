require "sequel"

DB = Sequel.sqlite(File.expand_path("./twindex.db", __dir__))

def load_models
  Dir[File.expand_path("./**/*.rb", __dir__)].each do |file|
    require file
  end
end
