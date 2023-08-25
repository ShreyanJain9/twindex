require "sqlite3"
require "sequel"

DB = Sequel.sqlite(File.expand_path("./twindex.db", __dir__))

DB.execute("CREATE VIRTUAL TABLE IF NOT EXISTS twts_fts USING fts5(content, tokenize=porter);")

DB.execute("INSERT OR REPLACE INTO twts_fts(content) SELECT content FROM twts;")
