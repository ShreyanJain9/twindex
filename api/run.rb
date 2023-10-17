require_relative "../app"
require "sinatra/base"
require "sinatra/contrib"
require "rack/contrib"
require_relative "../graphql/types"

module Twindex
  class API < Sinatra::Base
    use(Rack::JSONBodyParser)
  end
end

require_relative "routes/registry"
require_relative "routes/graphql"
