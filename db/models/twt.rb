class Twt < Sequel::Model
  many_to_one(:feed, class: :Feed)
  one_to_many(:mentions, class: :Mention)

  def self.create_from_json(tweet, feed)
    Twt.first(hash: tweet[:hash]).then do |twt|
      twt ? twt : feed.add_twt(
        created_at: DateTime.parse(tweet[:created_at]).to_s,
        content: tweet[:twt][:content],
        original: tweet[:twt][:original],
        reply_to: tweet[:twt][:reply_to],
        hash: tweet[:hash],
      ).tap do |twt|
        tweet[:twt][:mentions]&.each do |mention|
          Feed.from_url(mention[:url]).then {
            |feed_mention|
            twt.add_mention(Mention.create(
              feed: feed_mention.tap(&method(:puts)),
            ))
          }
        end
      end
    end
  end
end

class Feed < Sequel::Model
  one_to_many(:twts, class: :Twt)
  one_to_many(:mentions, class: :Mention)

  def self.from_url(url)
    Feed.first(url: url).then do |feed|
      if feed
        feed
      else
        Feed.create(url: url)
      end
    end
  end

  def self.from_metadata(metadata)
    Feed.from_url(metadata[:url]).tap do |feed|
      if feed
        # Update existing feed with new metadata
        feed.update(
          nick: metadata[:nick],
          avatar: metadata[:avatar],
        )
      else
        # Create a new feed if it doesn't exist
        feed = Feed.create(
          nick: metadata[:nick],
          url: metadata[:url],
          avatar: metadata[:avatar],
        )
      end
      metadata[:follow]&.each do |user|
        follow_feed = Feed.from_url(user[:url])

        Follow.create(
          follower_id: (feed.id),
          following_url: follow_feed.url,
          follow_nick: user[:username],
        )
      end
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
end

class Mention < Sequel::Model
  many_to_one(:feed, class: :Feed)
  many_to_one(:twt, class: :Twt)
end

class Follow < Sequel::Model
  many_to_one(:follower, class: :Feed, key: :follower_id)
end
