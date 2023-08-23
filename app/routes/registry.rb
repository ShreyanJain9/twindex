class TwindexAPI
  get("/api/plain/tweets") do
    content_type :"text/plain"
    ::API.plain_search(params[:q]).join "\n"
  end
end
