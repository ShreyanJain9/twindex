def sync_new_feeds
  Feed.where(synced_at: nil).all.each(&:process)
end
