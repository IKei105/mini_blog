user1 = User.create!(
  userid: 'testOne',
  password: 'password123',
  password_confirmation: 'password123',
  introduction: 'テストユーザー1の紹介文です',
  blog_url: 'https://example.com/testone'
)

user2 = User.create!(
  userid: 'testTwo',
  password: 'password123',
  password_confirmation: 'password123',
  introduction: 'テストユーザー2の紹介文です',
  blog_url: 'https://example.com/testtwo'
)

user3 = User.create!(
  userid: 'testThree',
  password: 'password123',
  password_confirmation: 'password123',
  introduction: 'テストユーザー3の紹介文です',
  blog_url: 'https://example.com/testthree'
)

user4 = User.create!(
  userid: 'testFour',
  password: 'password123',
  password_confirmation: 'password123',
  introduction: 'テストユーザー4の紹介文です',
  blog_url: 'https://example.com/testfour'
)

user5 = User.create!(
  userid: 'testFive',
  password: 'password123',
  password_confirmation: 'password123',
  introduction: 'テストユーザー5の紹介文です',
  blog_url: 'https://example.com/testfive'
)

[user1, user2, user3, user4, user5].each do |user|
  30.times do |i|
    Post.create!(
      content: "テスト投稿です#{i + 1}",
      user: user
    )
  end
end
