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

  get "/feed" do
    @feed = Feed[params[:url]]
    {
      uri: @feed.url,
      nick: @feed.nick,
      avatar: @feed.avatar,
    }.to_json
  end

  get "/mentions" do
    content_type :"application/json"
    @mentions = mentions_of_feed(Feed[params[:id]])
    erb :mentions
  end
end
