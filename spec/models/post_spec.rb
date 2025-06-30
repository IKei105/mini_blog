require "rails_helper"

RSpec.describe Post, type: :model do
  it "contentが空なら無効" do
    post = Post.new(content: "")
    expect(post).not_to be_valid
  end

  it "contentが140文字を超えると無効" do
    post = Post.new(content: "a" * 141)
    expect(post).not_to be_valid
  end
end
