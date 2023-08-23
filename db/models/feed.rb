class Feed < Sequel::Model
  one_to_many(:twts, class: :Twt)
  one_to_many(:mentions, class: :Mention)
  class << self
    def from_url(url)
      Feed.first(url: url).then do |feed|
        if feed
          feed
        else
          Feed.create(url: url)
        end
      end
    end

    def from_metadata(metadata)
      Feed.from_url(metadata[:url]).tap do |feed|
        feed.update(
          nick: metadata[:nick],
          avatar: metadata[:avatar],
          bio: metadata[:description],
        )
        metadata[:follow]&.each do |user|
          follow_feed = Feed.from_url(user[:url])

          Follow.create(
            follower_id: feed.id,
            following_id: follow_feed.id,
            follow_nick: user[:username],
          )
        end
      end
    end

    def [](url) ## or DB ID
      (super(url) || Feed.first(url: url))
    end

    def all_synced
      Feed.all.partition(&:synced?)[0]
    end

    def all_unsynced
      Feed.all.partition(&:synced?)[1]
    end

    def Update(id)
      FetchTwts.from(Feed[id].url).then do |feed_raw|
        Feed.from_metadata(feed_raw[:metadata]).update_time.tap do |feed_in_db|
          feed_raw[:twts].map {
            |twt|
            Twt.create_from_json(twt, feed_in_db)
          }
        end
      end
    end
  end

  def process
    Feed::Update(self.id)
  end

  def update_time()
    self.synced_at = DateTime.now
    self.save
    self
  end

  def mentioners
    self.mentions.map(&:twt)
  end

  def followers
    Follow.where(following_id: self.id).all
  end

  def follows
    Follow.where(follower_id: self.id).all
  end

  def to_s
    "#<Feed(#{self.url})>"
  end

  def synced?
    !(self.synced_at.nil?)
  end

  def update_metadata
    Feed.from_metadata(FetchTwts.from(self.url)[:metadata])
  end
end
