require 'rails_helper'

RSpec.describe "User follow/unfollow", type: :system do
  let!(:user) { create(:user, password: "password123", password_confirmation: "password123") }
  let!(:followed_user) { create(:user) }

  before do
    driven_by(:rack_test)

    create(:post, user: followed_user, content: "こんにちは")

    visit new_user_session_path
    fill_in "ユーザーID", with: user.userid
    fill_in "パスワード", with: "password123"
    click_button "ログイン"

    visit root_path
  end

  it "フォロー・フォロー解除ボタンが切り替わる" do
    expect(page).to have_button("フォロー")

    click_button "フォロー"
    expect(page).to have_button("フォロー中")

    click_button "フォロー中"
    expect(page).to have_button("フォロー")
  end

  it "フォロー中タイムラインにフォローしたユーザーの投稿のみ表示される" do
    click_button "フォロー"
    expect(page).to have_button("フォロー中")

    click_link "フォロー中"

    expect(page).to have_content("こんにちは")

    unfollowed_user = create(:user)
    create(:post, user: unfollowed_user, content: "未フォロー投稿")
    visit posts_following_path
    expect(page).not_to have_content("未フォロー投稿")
  end
end
