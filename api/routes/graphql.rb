module Twindex
  class API
    post("/graphql") {
      json(TwindexSchema.execute(
        params[:query],
        variables: params[:variables],
        context: { current_user: nil },
      ).to_h)
    }
  end
end
