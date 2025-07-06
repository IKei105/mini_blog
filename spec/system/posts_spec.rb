require 'rails_helper'

RSpec.describe "Posts", type: :system do
  let(:user) { create(:user) }

  before do
    driven_by(:rack_test) # Capybaraのドライバ（JS不要ならこれでOK）
  end

  it "ログインして投稿できる" do
    # ログイン
    visit new_user_session_path
    fill_in "ユーザーID", with: user.userid
    fill_in "パスワード", with: "password123"
    click_button "ログイン"

    # 投稿フォームにアクセス（トップページ想定）
    visit root_path
    fill_in "post_content", with: "これは統合テストの投稿です"
    click_button "投稿する"

    # 投稿が表示されているか
    expect(page).to have_content("これは統合テストの投稿です")
  end
end
