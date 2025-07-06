require 'rails_helper'

RSpec.describe "User authentication flow", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "ユーザー登録" do
    it "登録成功時にトップページへ遷移し、ログイン状態になっている" do
      visit new_user_registration_path

      fill_in "ユーザーID", with: "newuser"
      fill_in "パスワード", with: "password123"
      fill_in "再度パスワードを入力", with: "password123"
      fill_in "自己紹介", with: "はじめまして"
      fill_in "ブログURL", with: "https://example.com"

      click_button "登録"

      expect(current_path).to eq root_path
      expect(page).to have_content("ログアウト")
    end

    it "無効な入力で登録に失敗し、エラーメッセージが表示される" do
      visit new_user_registration_path

      click_button "登録"

      expect(page).to have_content("ユーザーIDを入力してください")
      expect(page).to have_content("パスワードを入力してください")
      expect(page).to have_content("確認用パスワードを入力してください")
      expect(page).to have_content("自己紹介を入力してください")
      expect(page).to have_content("ブログURLを入力してください")
    end
  end

  describe "ログイン / ログアウト" do
    let!(:user) { create(:user, password: "password123", password_confirmation: "password123") }

    it "正しい情報でログインできる" do
      visit new_user_session_path
      fill_in "ユーザーID", with: user.userid
      fill_in "パスワード", with: "password123"
      click_button "ログイン"

      expect(page).to have_content("ログアウト")
    end

    it "間違った情報ではログインできない" do
      visit new_user_session_path
      fill_in "ユーザーID", with: user.userid
      fill_in "パスワード", with: "wrongpassword"
      click_button "ログイン"

      expect(page).to have_content("ユーザーIDまたはパスワードが間違っています")
    end

    it "ログイン後、ログアウトボタンを押すとログアウトされる" do
      visit new_user_session_path
      fill_in "ユーザーID", with: user.userid
      fill_in "パスワード", with: "password123"
      click_button "ログイン"

      click_button "ログアウト"
      expect(page).to have_link("ログイン", href: new_user_session_path)
    end
  end
end
