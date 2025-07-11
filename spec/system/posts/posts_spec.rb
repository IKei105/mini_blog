require 'rails_helper'

RSpec.describe "Posts", type: :system do
  let(:user) { create(:user, password: "password123") }

  before do
    driven_by(:rack_test)
  end

  it "ログインして投稿できる" do
    visit new_user_session_path
    fill_in "ユーザーID", with: user.userid
    fill_in "パスワード", with: "password123"
    click_button "ログイン"

    visit root_path
    fill_in "post_content", with: "これは統合テストの投稿です"
    click_button "投稿する"

    expect(page).to have_content("これは統合テストの投稿です")
  end

  it "空文字だと投稿できず、エラーメッセージが表示される" do
    visit new_user_session_path
    fill_in "ユーザーID", with: user.userid
    fill_in "パスワード", with: "password123"
    click_button "ログイン"

    visit root_path
    fill_in "post_content", with: ""
    click_button "投稿する"

    expect(page).to have_content("投稿に失敗しました") # バリデーションメッセージに合わせて
  end

  it "140文字を超えると投稿できず、エラーメッセージが表示される" do
    visit new_user_session_path
    fill_in "ユーザーID", with: user.userid
    fill_in "パスワード", with: "password123"
    click_button "ログイン"

    visit root_path
    fill_in "post_content", with: "あ" * 141
    click_button "投稿する"

    expect(page).to have_content("投稿に失敗しました")
  end

end
