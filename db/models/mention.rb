class Mention < Sequel::Model
  many_to_one(:feed, class: :Feed)
  many_to_one(:twt, class: :Twt)

  def to_h
    {
      user: self.feed.nick,
      url: self.feed.url,
    }
  end
end
