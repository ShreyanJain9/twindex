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
      argument(:id, ID, required: true) ## Can be the URL too, since Feed.[] takes ID or URL
    end

    field(:twt, API::TwtType, null: false) do
      argument(:hash, ID, required: true)
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
