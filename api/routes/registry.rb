class TwindexAPI
  get("/api/plain/tweets") do
    content_type :"text/plain"
    ::API.plain_search(params[:q]).join "\n"
  end

  get("/api/plain/tweets/") do
    content_type :"text/plain"
    ## get newest twts based on created_at and return them in reverse chronological order
    ## newest twts first
    Twindex.get_latest_twts.map(&:to_registry_plain).join "\n"
  end
end
