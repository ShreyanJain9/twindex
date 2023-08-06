require_relative "extensions"

module TwtParser
  using Twindex::Extensions

  def self.parse_twt(twt)
    twt.match(/(?:\(#(\w+)\))?\s*((?:@<(\w+)\s+(https?|gopher|gemini)?:\/\/\S+>\s*)*)(.*)/)
      .then { |match_data|
      match_data ? {
        reply_to: match_data[1],
        mentions: match_data[2].scan(/@<(\w+)\s+((https?|gopher|gemini)?:\/\/\S+)>/).map { |m| { name: m[0], url: m[1] } },
        content: match_data.to_a.at(5) || match_data[4],
        original: twt,
      }.reject_empty : nil
    }
  end
end
