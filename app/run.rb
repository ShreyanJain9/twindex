require_relative "../app"
require "sinatra/base"

class TwindexAPI < Sinatra::Base
  get "/" do
    "Hello World!"
  end

  get "/profile" do
    @profile = Feed[params[:id]]
    erb :profile
  end

  post "/graphql" do
    result = API::TwindexSchema.execute(
      params[:query],
      variables: params[:variables],
    )
    json(result.to_h)
  end
end
