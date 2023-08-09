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

  def mentioned_feeds
    self.mentions.map(&:feed)
  end

  def to_s
    "#{created_at().to_datetime.rfc3339}\t#{original()}"
  end
end
