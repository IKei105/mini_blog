class Follow < ApplicationRecord
  belongs_to :followed, class_name: "User"
  belongs_to :follower, class_name: "User"

  validates :followed_id, uniqueness: { scope: :follower_id, message: "はすでにフォローしています" }
  validate :cannot_follow_yourself

  private

  def cannot_follow_yourself
    if followed_id == follower_id
      errors.add(:followed_id, "は自分自身をフォローできません")
    end
  end
end
