class User < ApplicationRecord
  # devise
  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :validatable,
       authentication_keys: [:userid]

  has_many :posts, dependent: :nullify

  # 自分がフォローしているユーザー
  has_many :follows, foreign_key: :follower_user_id, dependent: :destroy # 中間テーブル
  has_many :follow_users, through: :follows, source: :follow_user # ユーザーの取得

  # 自分をフォローしてくれるユーザー
  has_many :reverse_follows, class_name: 'Follow', foreign_key: :follow_user_id, dependent: :destroy # 中間テーブル
  has_many :follower_users, through: :reverse_follows, source: :follower_user # ユーザーの取得

  # emailを必須にしないためのオーバーライド
  def email_required?
    false
  end

  def will_save_change_to_email?
    false
  end

  validates :userid,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: {
      with: /\A[a-zA-Z]+\z/,
      message: "はアルファベットのみ使用可能です"
    }
  
  validate :userid_no_spaces
  validates :introduction, presence: true, length: { maximum: 200 }
  validates :blog_url, presence: true, format: { with: /\Ahttps?:\/\/.+\z/, message: "は有効なURLではありません" }

  private

  def userid_no_spaces
    if userid&.match?(/\s/)
      errors.add(:userid, "にスペースは使えません")
    end
  end

end

