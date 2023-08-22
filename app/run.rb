require_relative "../app"
require "sinatra/base"
require "sinatra/contrib"
require "rack/contrib"
require_relative "../graphql/types"

class TwindexAPI < Sinatra::Base
  use(Rack::JSONBodyParser)
  post("/graphql") {
    json(TwindexSchema.execute(
      params[:query],
      variables: params[:variables],
      context: { current_user: nil },
    ).to_h)
  }
end
