require_relative "lib/twt_hash/hash"
require_relative "lib/fetch"
require_relative "db/db"

load_models()

def sync_new_feeds
  Feed.where(synced_at: nil).all.each(&:process)
end
