require "graphql"
require_relative "../app"
load_models()

Relative("./types").then do |dir|
  Dir["#{dir}/**/*.rb"].each do |file|
    require file
  end
end

module API
  class QueryType < GraphQL::Schema::Object
    field(:feed, API::FeedType, null: false) do
      argument(:url, ID, required: true) {
        description("The URL of the feed. Its ID in the indexer's database can be used as well.")
      }
      ## Can be the either, since Feed.[] takes ID or URL
    end

    field(:twt, API::TwtType, null: false) do
      argument(:hash, ID, required: true) {
        description("The hash of the twt, per https://dev.twtxt.net/doc/twthashextension.html")
      }
    end

    field(:twts, [API::TwtType]) {
      argument(:query, String, required: true) do
        description("A list of twts which match the query.")
      end
    }

    def feed(url:)
      Feed[url]
    end

    def twt(hash:)
      Twt[hash]
    end

    def twts(query:)
      search_twts(query)
    end
  end

  def self.plain_search(query)
    search_twts(query).map(&:to_registry_plain)
  end
end

class TwindexSchema < GraphQL::Schema
  query(API::QueryType)
end
