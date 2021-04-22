class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def self.confirm_friend(user)
    current_friendship = find_by(user_id: user.id)
    current_friendship.confirmed = true
    current_friendship.save
    inverted_user = current_friendship.friend
    new_friendship = inverted_user.friendships.build(friend: user, confirmed: true)
    new_friendship.save
  end

  def self.reject_friend(user)
    current_friendship = find_by(user_id: user.id)
    current_friendship.destroy
  end
end
