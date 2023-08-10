module API
  class TwtType < GraphQL::Schema::Object
    description("A specific twt.")

    field(:hash, ID, null: false, resolver_method: :resolve_hash) {
      description("The hash of the twt, per https://dev.twtxt.net/doc/twthashextension.html")
    }

    def resolve_hash
      object[:hash]
    end

    field(:created_at, GraphQL::Types::ISO8601DateTime, description: "Timestamp of the twt.")
    field(:content, String, description: "The content of the twt, excluding metadata.")
    field(:original, String, description: "The raw twt, including metadata but excluding timestamp.")
    field(:reply_to, String) {
      description("The hash of the twt that this twt is a reply to.")
    }
    field(:parent, API::TwtType) {
      description("The twt this twt is a reply to.")
    }
    field(:mentions, [API::MentionType]) {
      description("A list of mentioned feeds in the twt.")
    }
    field(:feed, API::FeedType) {
      description("The twtxt feed the twt belongs to.")
    }
    field(:replies, [API::TwtType]) {
      description("A list of replies to the twt.")
    }
  end
end

add_twts_to_mentiontype()
add_twts_to_feedtype()
