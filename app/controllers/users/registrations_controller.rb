class Users::RegistrationsController < Devise::RegistrationsController
  # サインアップ(createアクション)の前に追加のパラメータ許可設定を実行
  before_action :configure_sign_up_params, only: [:create]

  protected

  # サインアップ時に :introduction と :blog_url の入力を許可するメソッド
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:introduction, :blog_url])
  end

  def after_sign_up_path_for(resource)
    root_path
  end
end
