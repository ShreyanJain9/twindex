require_relative "extensions"

module TwtParser
  using Twindex::Extensions
  def self.parse_twt(twt)
    match_data = twt.match(/(?:\(#(\w+)\))?\s*((?:@<(\w+)\s+(https?|gopher|gemini)?:\/\/\S+>\s*)*)(.*)/)
    if match_data
      reply_to = match_data[1]
      mentions = match_data[2].scan(/@<(\w+)\s+((https?|gopher|gemini)?:\/\/\S+)>/) # Extract all mentions as pairs
      content = match_data.to_a.at(5) || match_data[4]

      {
        reply_to: reply_to,
        mentions: (mentions.map { |m| { name: m[0], url: m[1] } }),
        content: content,
        original: twt,
      }.reject_empty
    end
  end
end
