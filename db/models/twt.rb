class Twt < Sequel::Model
  # ... (existing code remains the same) ...

  def self.create_from_json(tweet, feed)
    Twt.first(hash: tweet[:hash]).then do |twt|
      twt ? twt : feed.add_twt(
        created_at: DateTime.parse(tweet[:created_at]).to_s,
        content: tweet[:twt][:content],
        original: tweet[:twt][:original],
        reply_to: tweet[:twt][:reply_to],
        hash: tweet[:hash],
      ).tap do |twt|
        begin
          tweet[:twt][:mentions]&.each do |mention|
            Feed.from_url(mention[:url]).then { |feed_mention| twt.add_mention(Mention.create(feed: feed_mention.tap(&method(:puts)))) }
          end
        rescue => e
          puts "Error in create_from_json: #{e.message}"
        end
      end
    end
  end
end

class Feed < Sequel::Model
  # ... (existing code remains the same) ...

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
          begin
            metadata[:follow]&.each do |user|
              Feed.from_url(user[:url]).then { |follow_feed| Follow.find_or_create(follower_id: db_feed.id, following_id: follow_feed.id) }
            end
          rescue => e
            puts "Error in from_metadata: #{e.message}"
          end
        end
      end
    end
  end

  def process
    FetchTwts.from(url).then do |raw|
      Feed.from_metadata(raw[:metadata]).tap do |db_feed|
        begin
          raw[:twts].map do |twt|
            Twt.create_from_json(twt.tap(&method(:puts)), db_feed)
          end
        rescue => e
          puts "Error in process: #{e.message}"
        end
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
