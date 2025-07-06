require 'rails_helper'

RSpec.describe User, type: :model do
  describe "User registration" do
    let(:valid_attributes) do
      {
        userid: "TestUser",
        password: "password123",
        password_confirmation: "password123",
        introduction: "Hello, I am a user.",
        blog_url: "http://example.com"
      }
    end

    # 有効な属性が与えられた時のテスト
    it "is valid with valid attributes" do
      user = User.new(valid_attributes)
      expect(user).to be_valid
    end

    # useridが空文字のテスト
    it "is invalid without userid" do
      user = User.new(valid_attributes.merge(userid: ""))
      user.valid?
      expect(user.errors[:userid]).to include("ユーザーIDを入力してください")
    end

    # useridにスペースが含まれるテスト
    it "is invalid if userid includes spaces" do
      user = User.new(valid_attributes.merge(userid: "invalid id"))
      user.valid?
      expect(user.errors[:userid]).to include("にスペースは使えません")
    end

    # useridにアルファベット以外が含まれるテスト
    it "is invalid if userid contains non-alphabet characters" do
      user = User.new(valid_attributes.merge(userid: "user123"))
      user.valid?
      expect(user.errors[:userid]).to include("はアルファベットのみ使用可能です")
    end

    # 大文字小文字区別ないか確認するテスト
    it "is invalid if userid is not unique (case insensitive)" do
      User.create!(valid_attributes)
      user2 = User.new(valid_attributes.merge(userid: "testuser"))
      user2.valid?
      expect(user2.errors[:userid]).to include("すでに使用されています")
    end

    # パスワードが短すぎるテスト
    it "is invalid if password is too short" do
      user = User.new(valid_attributes.merge(password: "123", password_confirmation: "123"))
      user.valid?
      expect(user.errors[:password]).to include("パスワードは6文字以上で入力してください")
    end

    # User登録時にユーザー数が増加するか確認するテスト
    it "increments user count when a user is created" do
      expect {
        User.create!(valid_attributes)
      }.to change(User, :count).by(1)
    end

    # introductionが空の場合は無効（空禁止）であることのテスト
    it "is invalid without introduction" do
      user = User.new(valid_attributes.merge(introduction: ""))
      user.valid?
      expect(user.errors[:introduction]).to include("自己紹介を入力してください")
    end

    it "is invalid if introduction is too long" do
      user = User.new(valid_attributes.merge(introduction: "a" * 201))
      user.valid?
      expect(user.errors[:introduction]).to include("自己紹介は200文字以内で入力してください")
    end

    # blog_urlが空の場合は無効（空禁止）であることのテスト
    it "is invalid without blog_url" do
      user = User.new(valid_attributes.merge(blog_url: ""))
      user.valid?
      expect(user.errors[:blog_url]).to include("ブログURLを入力してください")
    end

    # blog_urlに有効なURLを許容するテスト
    it "accepts valid blog_url format" do
      valid_urls = [ "http://example.com", "https://example.com" ]
      valid_urls.each do |url|
        user = User.new(valid_attributes.merge(blog_url: url))
        expect(user).to be_valid
      end
    end

    # blog_urlに不正なURLの場合は無効であることのテスト
    it "is invalid with an invalid blog_url format" do
      user = User.new(valid_attributes.merge(blog_url: "invalid-url"))
      user.valid?
      expect(user.errors[:blog_url]).to include("有効なURLを入力してください")
    end
  end
end
