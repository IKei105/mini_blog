class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :validatable,
       authentication_keys: [ :username ]

  has_many :posts, dependent: :nullify


  has_many :follows, foreign_key: :follower_user_id, dependent: :destroy
  has_many :follow_users, through: :follows, source: :follow_user


  has_many :reverse_follows, class_name: "Follow", foreign_key: :follow_user_id, dependent: :destroy
  has_many :follower_users, through: :reverse_follows, source: :follower_user

  def email_required?
    false
  end

  def will_save_change_to_email?
    false
  end

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
