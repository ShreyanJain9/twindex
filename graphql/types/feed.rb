module API
  class FeedType < GraphQL::Schema::Object
    description("A twtxt feed on the network.")
    field(:id, ID, null: false) {
      description("The ID of the feed in the indexer's database. Not usually useful.")
    }
    field(:url, String, null: false) {
      description("The URL of the feed.")
    }
    field(:nick, String) {
      description("The human-readable nickname of the feed set by the feed's owner.")
    }
    field(:avatar, String) {
      description("A url to the avatar image of the feed set by the feed's owner.")
    }
    field(:synced_at, GraphQL::Types::ISO8601DateTime) {
      description("The last time the indexer crawled the feed.")
    }
    field(:bio, String) {
      description("A description of the feed, set by the feed's owner.")
    }
  end
end

def add_follows_to_feedtype
  API::FeedType.field(:follows, [API::FollowType]) {
    description("A list of the feeds the feed (explicitly reveals it) follows.")
  }
  API::FeedType.field(:followers, [API::FollowType]) {
    description("A list of the feeds that (explicitly reveal they) follow this feed.")
  }
end

def add_twts_to_feedtype
  API::FeedType.field(:twts, [API::TwtType]) {
    description("A list of the twts the feed has published.")
  }
end

def add_mentions_to_feedtype
  API::FeedType.field(:mentions, [API::MentionType]) {
    description("A list of the twts that mention this feed. Useful for generating notifications.")
  }
end
