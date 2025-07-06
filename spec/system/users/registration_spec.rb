require 'rails_helper'

RSpec.describe "UserRegistrations", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "新規登録できる" do
    visit new_user_registration_path

    fill_in "ユーザーID", with: "newuser"
    fill_in "パスワード", with: "password123"
    fill_in "再度パスワードを入力", with: "password123"
    fill_in "自己紹介", with: "よろしくお願いします"
    fill_in "ブログURL", with: "https://example.com"

    click_button "登録"

    expect(page).to have_content("ログアウト")
  end
end
