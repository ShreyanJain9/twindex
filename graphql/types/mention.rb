module API
  class MentionType < GraphQL::Schema::Object
    field(:id, ID, null: false)
    field(:feed, API::FeedType, null: false)
  end
end

def add_twts_to_mentiontype
  API::MentionType.field(:twt, [API::TwtType])
end
