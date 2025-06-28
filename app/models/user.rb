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
end
