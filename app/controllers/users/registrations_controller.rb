class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [ :create ]

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :introduction, :blog_url ])
  end

  def after_sign_up_path_for(resource)
    root_path
  end
end
