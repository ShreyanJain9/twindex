def sync_new_feeds
  Feed.where(synced_at: nil).all.each(&:process)
end

def mentions_of_feed(feed)
  feed.mentions.map(&:twt)
end
