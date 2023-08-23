require "sqlite3"

# Open the database connection
DB_SEARCH = SQLite3::Database.new (File.expand_path("./twindex.db", __dir__))

def search_twts(query)
  DB_SEARCH.execute("SELECT * FROM twts_fts WHERE content MATCH ?", [query])
    .map { |row| Twt.where(content: row[0]).first }
    .compact.uniq
end
