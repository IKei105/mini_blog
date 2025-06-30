class Post < ApplicationRecord
    belongs_to :user, optional: true  # optional: true にして user_id が NULL でも保存可能にする
    validates :content, presence: true, length: { maximum: 140 }
end
