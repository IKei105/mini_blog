require "rails_helper"

RSpec.describe "Posts Pagination", type: :request do
    let(:user) { create(:user) }
    
    before do
        31.times do |i|
        Post.create!(content: "投稿 #{i + 1}", user: user)
        end
    end

    it "30件を超える投稿をした時にページネーションを表示" do
        get posts_path, params: { page: 1 }
        expect(response.body).to include("1")
        expect(response.body).to include("2")
    end

    it "2ページ目に1ページ目のコンテンツがないのを確認" do
        get posts_path, params: { page: 2 }
        expect(response.body).to include("投稿 1")
        expect(response.body).not_to include("投稿 31")
    end
end
