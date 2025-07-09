class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :validatable,
       authentication_keys: [ :username ]

  has_many :posts, dependent: :nullify

  has_many :follows, foreign_key: :follower_id, dependent: :destroy
  has_many :followings, through: :follows, source: :followed

  has_many :followed_relationships, class_name: "Follow", foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :followed_relationships, source: :follower

  validates :username,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: {
      with: /\A[a-zA-Z]+\z/,
      message: "はアルファベットのみ使用可能です"
    }

  validate :username_no_spaces
  validates :introduction, presence: true, length: { maximum: 200 }
  validates :blog_url, presence: true, format: { with: /\Ahttps?:\/\/.+\z/, message: "は有効なURLではありません" }

  def email_required?
    false
  end

  def will_save_change_to_email?
    false
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (username = conditions.delete(:username))
      where(conditions).where("LOWER(username) = ?", username.downcase).first
    else
      where(conditions).first
    end
  end

  private

  def username_no_spaces
    if username&.match?(/\s/)
      errors.add(:username, "にスペースは使えません")
    end
  end

end
