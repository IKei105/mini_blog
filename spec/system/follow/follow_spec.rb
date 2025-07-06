require 'rails_helper'

RSpec.describe "User follow/unfollow", type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }

  before do
    driven_by(:rack_test)

    # ログイン処理
    visit new_user_session_path
    fill_in "ユーザーID", with: user.userid
    fill_in "パスワード", with: "password123"
    click_button "ログイン"

    # other_user の投稿を作成して root_path で表示されるようにする
    create(:post, user: other_user, content: "こんにちは")

    visit root_path
  end

  it "他ユーザーをフォローでき、フォロー解除もできる" do
    expect(page).to have_button("フォロー")

    click_button "フォロー"
    expect(page).to have_button("フォロー中")

    click_button "フォロー中"
    expect(page).to have_button("フォロー")
  end
end
