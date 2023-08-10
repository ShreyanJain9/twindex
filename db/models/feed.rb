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
  end

  def process
    FetchTwts.from(url).then do |raw|
      Feed.from_metadata(raw[:metadata]).tap do |db_feed|
        raw[:twts].map {
          |twt|
          Twt.create_from_json(twt.tap(&method(:puts)), db_feed)
        }
      end
    end
    self.update_time
  end

  def update_time()
    self.synced_at = DateTime.now
    self.save
  end

  def mentioners
    self.mentions.map(&:twt)
  end

  def followers
    Follow.where(following_id: self.id).all
  end

  def following
    Follow.where(follower_id: self.id).all
  end

  def to_s
    "#<Feed(#{self.url})>"
  end
end
