class Follow < ApplicationRecord
  belongs_to :followed, class_name: "User"
  belongs_to :follower, class_name: "User"

  validates :follow_user_id, uniqueness: { scope: :follower_user_id, message: "はすでにフォローしています" }
  validate :cannot_follow_yourself

  private

  def cannot_follow_yourself
    if follow_user_id == follower_user_id
      errors.add(:follow_user_id, "は自分自身をフォローできません")
    end
  end
end
