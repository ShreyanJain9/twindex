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
    Feed.from_url(metadata[:url]).then do |feed|
      if feed
        feed
      else
        Feed.find_or_create(
          username: metadata[:nick],
          url: metadata[:url].tap(&method(:puts)),
          avatar: metadata[:avatar],
        ).tap do |db_feed|
          metadata[:follow]&.each do |user|
            Feed.from_url(
              user[:url]
            )
              .then {
              |follow_feed|
              Follow.find_or_create( #TODO MAKE THIS WORK
                follower_id: db_feed.id,
                following_id: follow_feed.id,
              ) # unless db_feed[:url] == follow_feed[:url]
            }
          end
        end
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
  end
end

class Mention < Sequel::Model
  many_to_one(:feed, class: :Feed)
  many_to_one(:twt, class: :Twt)
end

class Follow < Sequel::Model
  many_to_one(:follower, class: :Feed, key: :follower_id)
  many_to_one(:following, class: :Feed, key: :following_id)
end
