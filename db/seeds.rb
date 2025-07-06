# db/seeds.rb

# ユーザー作成
user1 = User.create!(
  userid: 'testone',
  password: 'password123',
  password_confirmation: 'password123',
  introduction: 'テストユーザー1の紹介文です',
  blog_url: 'https://example.com/testone'
)

user2 = User.create!(
  userid: 'testtwo',
  password: 'password123',
  password_confirmation: 'password123',
  introduction: 'テストユーザー2の紹介文です',
  blog_url: 'https://example.com/testtwo'
)

# 投稿作成
[user1, user2].each do |user|
  5.times do |i|
    Post.create!(
      content: "テスト投稿です#{i + 1}",
      user: user
    )
  end
end
