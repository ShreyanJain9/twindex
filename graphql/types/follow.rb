module API
  class FollowType < GraphQL::Schema::Object
    field(:id, ID, null: false)
    field(:follower, API::FeedType, null: false)
    field(:following, API::FeedType, null: false)
  end
end

add_follows_to_feedtype()
