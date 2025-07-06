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

    it "有効な属性が与えられた時のテスト" do
      user = User.new(valid_attributes)
      expect(user).to be_valid
    end

    it "useridが空文字のテスト" do
      user = User.new(valid_attributes.merge(userid: ""))
      user.valid?
      expect(user.errors[:userid]).to include("ユーザーIDを入力してください")
    end

    it "useridにスペースが含まれるテスト" do
      user = User.new(valid_attributes.merge(userid: "invalid id"))
      user.valid?
      expect(user.errors[:userid]).to include("にスペースは使えません")
    end

    it "useridにアルファベット以外が含まれるテスト" do
      user = User.new(valid_attributes.merge(userid: "user123"))
      user.valid?
      expect(user.errors[:userid]).to include("はアルファベットのみ使用可能です")
    end

    it "大文字小文字区別ないか確認するテスト" do
      User.create!(valid_attributes)
      user2 = User.new(valid_attributes.merge(userid: "testuser"))
      user2.valid?
      expect(user2.errors[:userid]).to include("すでに使用されています")
    end

    it "パスワードが短すぎるテスト" do
      user = User.new(valid_attributes.merge(password: "123", password_confirmation: "123"))
      user.valid?
      expect(user.errors[:password]).to include("パスワードは6文字以上で入力してください")
    end

    it "User登録時にユーザー数が増加するか確認するテスト" do
      expect {
        User.create!(valid_attributes)
      }.to change(User, :count).by(1)
    end

    it "introductionが空の場合は無効（空禁止）であることのテスト" do
      user = User.new(valid_attributes.merge(introduction: ""))
      user.valid?
      expect(user.errors[:introduction]).to include("自己紹介を入力してください")
    end

    it "自己紹介文が200文字を超過した際のテスト" do
      user = User.new(valid_attributes.merge(introduction: "a" * 201))
      user.valid?
      expect(user.errors[:introduction]).to include("自己紹介は200文字以内で入力してください")
    end

    it "blog_urlが空の場合は無効（空禁止）であることのテスト" do
      user = User.new(valid_attributes.merge(blog_url: ""))
      user.valid?
      expect(user.errors[:blog_url]).to include("ブログURLを入力してください")
    end

    it "blog_urlに有効なURLを許容するテスト" do
      valid_urls = ["http://example.com", "https://example.com"]
      valid_urls.each do |url|
        user = User.new(valid_attributes.merge(blog_url: url))
        expect(user).to be_valid
      end
    end

    it "blog_urlに不正なURLの場合は無効であることのテスト" do
      user = User.new(valid_attributes.merge(blog_url: "invalid-url"))
      user.valid?
      expect(user.errors[:blog_url]).to include("有効なURLを入力してください")
    end
  end
end
