require 'rails_helper'

RSpec.describe "フォロー機能", type: :system do
  let(:user) { create(:user, password: "password", password_confirmation: "password") }
  let(:other_user) { create(:user, userid: "targetuser", password: "password", password_confirmation: "password") }

  before do
    driven_by(:selenium_chrome_headless)

    # ログイン
    visit new_user_session_path
    fill_in "ユーザーID", with: user.userid
    fill_in "パスワード", with: "password"
    click_button "ログイン"
  end

  it "フォロー・フォロー解除ができる" do
    # 他のユーザーの投稿を表示
    Post.create!(user: other_user, content: "テスト投稿")

    visit root_path

    # フォローボタンがあることを確認して押す
    expect(page).to have_button("フォロー")
    click_button "フォロー"

    # ボタンが切り替わったか確認
    expect(page).to have_button("フォロー中")

    # もう一度押すとフォロー解除
    click_button "フォロー中"
    expect(page).to have_button("フォロー")
  end
end
