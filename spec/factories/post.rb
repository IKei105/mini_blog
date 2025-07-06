FactoryBot.define do
  factory :post do
    content { "テスト投稿" }
    association :user
  end
end