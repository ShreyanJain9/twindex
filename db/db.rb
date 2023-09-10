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
  extend T::Sig

  sig { params(limit: Integer).returns(T::Array[Twt]) }
  def self.get_latest_twts(limit = 10)
    DB["SELECT hash FROM twts ORDER BY created_at DESC LIMIT #{limit};"].all.map do |hash|
      Twt[hash[:hash]]
    end
  end
end
