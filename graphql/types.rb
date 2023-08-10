require "graphql"
require_relative "../app"
load_models()

File.expand_path("./types", __dir__).then do |dir|
  Dir["#{dir}/**/*.rb"].each do |file|
    require file
  end
end

module API
  class QueryType < GraphQL::Schema::Object
    field(:feed, API::FeedType, null: false) do
      argument(:id, ID, required: true) {
        description("The URL of the feed. Its ID in the indexer's database can be used as well.")
      }
      ## Can be the either, since Feed.[] takes ID or URL
    end

    field(:twt, API::TwtType, null: false) do
      argument(:hash, ID, required: true) {
        description("The hash of the twt, per https://dev.twtxt.net/doc/twthashextension.html")
      }
    end

    def feed(id:)
      Feed[id]
    end

    def twt(hash:)
      Twt[hash]
    end
  end
end

class TwindexSchema < GraphQL::Schema
  query(API::QueryType)
end
