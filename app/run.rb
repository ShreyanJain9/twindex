require_relative "../app"
require "sinatra/base"
require "sinatra/reloader" if ENV["RACK_ENV"] == "development"
require_relative "../graphql/types"

class TwindexAPI < Sinatra::Base
  get "/" do
    erb :index
  end

  get "/profile" do
    @profile = Feed[params[:id]]
    erb :profile
  end

  post "/graphql" do
    puts
    result = TwindexSchema.execute(
      GraphQL.parse(request.body.read), # TODO make this actually parse the darn string
    )
    result.to_h.to_json
  end
end
