module API
  class FeedType < GraphQL::Schema::Object
    description("A twtxt feed on the network.")
    field(:id, ID, null: false)
    field(:url, String, null: false)
    field(:nick, String)
    field(:avatar, String)
    field(:synced_at, GraphQL::Types::ISO8601DateTime)
  end
end

def add_follows_to_feedtype
  API::FeedType.field(:follows, [API::FollowType])
  API::FeedType.field(:followers, [API::FollowType])
end

def add_twts_to_feedtype
  API::FeedType.field(:twts, [API::TwtType])
end
