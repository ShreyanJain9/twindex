class Follow < Sequel::Model
  many_to_one(:follower, class: :Feed, key: :follower_id)
  many_to_one(:following, class: Feed, key: :following_id)

  def inspect
    "#<(#{self.id}) Follow: #{self.follower_id} => #{self.following_id} (with nick #{self.follow_nick})>"
  end
end
