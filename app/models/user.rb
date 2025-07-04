class User < ApplicationRecord
  # devise
  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :validatable,
       authentication_keys: [:userid]

  has_many :posts, dependent: :nullify

  # emailを必須にしないためのオーバーライド
  def email_required?
    false
  end

  def will_save_change_to_email?
    false
  end

  # useridを使った認証をDeviseで正しく機能させる
  # def self.serialize_from_session(*args)
  #   key = args[0]
  #   salt = args[1]

  #   userid = key.is_a?(Array) ? key[0] : key
  #   record = find_by(userid: userid)
  #   record if record && record.authenticatable_salt == salt
  # end

  # def self.serialize_from_session(key, salt)
  #   userid = key.is_a?(Array) ? key[0] : key
  #   record = find_by(userid: userid)
  #   record if record && record.authenticatable_salt == salt
  # end

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

