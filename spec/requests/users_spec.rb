require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "ユーザー登録・ログイン・プロフィール表示" do
    it "新規登録が成功する" do
      user_params = attributes_for(:user) # FactoryBot でハッシュ取得

      post user_registration_path, params: { user: user_params }
      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include("ログアウト")
    end

    it "ログインが成功する" do
      user = create(:user, password: "password123")

      post user_session_path, params: {
        user: {
          userid: user.userid,
          password: "password123"
        }
      }

      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include("ログアウト")
    end

    it "ユーザー詳細ページにアクセスして内容が見える" do
      user = create(:user)
      sign_in user

      get user_path(user)
      expect(response.body).to include(user.userid)
      expect(response.body).to include(user.introduction)
      expect(response.body).to include(user.blog_url)
    end
  end
end
