module API
  class MentionType < GraphQL::Schema::Object
    field(:id, ID, null: false)
    field(:feed, API::FeedType, null: false) {
      description("The feed the twt this mention is in mentioned.")
    }
  end
end

def add_twts_to_mentiontype
  API::MentionType.field(:twt, [API::TwtType]) {
    description("The twt this mention is in.")
  }
end

add_mentions_to_feedtype()
