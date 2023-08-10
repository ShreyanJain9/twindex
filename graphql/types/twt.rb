module API
  class TwtType < GraphQL::Schema::Object
    field(:hash, ID, null: false, resolver_method: :resolve_hash)

    def resolve_hash
      object[:hash]
    end

    field(:created_at, GraphQL::Types::ISO8601DateTime)
    field(:content, String)
    field(:original, String)
    field(:reply_to, String)
    field(:mentions, [API::MentionType])
    field(:feed, API::FeedType)
  end
end

add_twts_to_mentiontype()
add_twts_to_feedtype()
