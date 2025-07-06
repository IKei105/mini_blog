require 'rails_helper'

RSpec.describe Follow, type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  it "同じユーザーを2回フォローできない" do
    create(:follow, follow_user: other_user, follower_user: user)
    follow = Follow.new(follow_user: other_user, follower_user: user)
    expect(follow).not_to be_valid
    expect(follow.errors[:follow_user_id]).to include("はすでにフォローしています")
  end

  it "自分自身はフォローできない" do
    follow = Follow.new(follow_user: user, follower_user: user)
    expect(follow).not_to be_valid
    expect(follow.errors[:follow_user_id]).to include("は自分自身をフォローできません")
  end
end
