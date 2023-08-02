module Twindex
  module Models
    class Twt < Sequel::Model
      many_to_one(:feed, class: :Feed)

      def replies
        Twindex::Models::Twt.where(reply_to: self.hash).all
      end
    end

    class Feed < Sequel::Model
      one_to_many(:twt, class: :Twt)
    end
  end
end
