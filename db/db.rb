require "sequel"

DB = Sequel.sqlite(Relative("./twindex.db"))

def load_models
  Dir[Relative("./models/*.rb")].each do |file|
    require file
  end
end

def DB.cleanup_fts
  <<-SQL
DELETE FROM twts_fts
WHERE rowid NOT IN (
  SELECT MIN(rowid)
  FROM twts_fts
  GROUP BY content
)
  SQL
end

module Twindex
  def self.get_latest_twts
    DB["SELECT hash FROM twts ORDER BY created_at DESC LIMIT 10;"].all.map do |hash|
      Twt[hash[:hash]]
    end
  end
end
