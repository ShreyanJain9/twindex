require "sequel"

DB = Sequel.sqlite(Relative("./twindex.db"))

def load_models
  Dir[Relative("./models/*.rb")].each do |file|
    require file
  end
end
