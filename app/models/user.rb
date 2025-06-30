class User < ApplicationRecord
  # devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # emailを必須にしないためのオーバーライド
  def email_required?
    false
  end

  def will_save_change_to_email?
    false
  end

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

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

