class Mention < Sequel::Model
  many_to_one(:feed, class: :Feed)
  many_to_one(:twt, class: :Twt)
end
