FactoryBot.define do
  factory :user do
    # Userモデルのカラムのみを定義します
    sequence(:userid) { |n|
      letters = ('a'..'z').to_a
      # nは1から始まると想定
      first_index = ((n - 1) / 26) % 26   # 0〜25の範囲でループ
      second_index = (n - 1) % 26         # 0〜25の範囲でループ
      prefix = "user"
      "#{prefix}#{letters[first_index]}#{letters[second_index]}"
    }
    password { "password123" }
    password_confirmation { "password123" }
    introduction { "自己紹介テスト" } # ← Userのカラムになったのでここに直接定義
    blog_url { "http://example.com" } # ← Userのカラムになったのでここに直接定義
  end
end
