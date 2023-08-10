module API
  class FollowType < GraphQL::Schema::Object
    field(:id, ID, null: false)
    field(:follower, API::FeedType, null: false) {
      description("The feed that is doing the following.")
    }
    field(:following, API::FeedType, null: false) {
      description("The feed that is being followed.")
    }
  end
end

add_follows_to_feedtype()
