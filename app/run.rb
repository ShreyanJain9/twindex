require_relative "../app"
require "sinatra/base"
require "sinatra/contrib"
require "rack/contrib"
require "sinatra/reloader" if ENV["RACK_ENV"] == "development"
require_relative "../graphql/types"

class TwindexAPI < Sinatra::Base
  use(Rack::JSONBodyParser)

  get("/") { erb(:index) }

  get("/profile") { @profile = Feed[params[:id]]; erb(:profile) }

  post("/graphql") {
    json(TwindexSchema.execute(
      params[:query],
      variables: params[:variables],
      context: { current_user: nil },
    ).to_h)
  }
end
