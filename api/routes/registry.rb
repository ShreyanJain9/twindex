module Twindex
  class API
    get("/api/plain/tweets") do
      content_type :"text/plain"
      ::API.plain_search(params[:q]).join "\n"
    end

    ## get newest twts based on created_at and return them in reverse chronological order
    ## newest twts first
    get("/api/plain/tweets/") do
      content_type :"text/plain"
      Twindex.get_latest_twts(
        (params[:limit] || 10)
      )
        .map(&:to_registry_plain).join "\n"
    end
  end
end
