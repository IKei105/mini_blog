FactoryBot.define do
  factory :follow do
    association :follow_user, factory: :user
    association :follower_user, factory: :user
  end
end