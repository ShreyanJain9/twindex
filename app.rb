require "sorbet-runtime"
require_relative "lib/extensions"
require_relative "lib/twt_hash/hash"
require_relative "lib/fetch"
require_relative "db/db"
require_relative "db/indexer"
require_relative "db/search_twts"

load_models()

if __FILE__ == $0
  require "irb"
  IRB.start
end
