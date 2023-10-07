class Member::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!, except: [:new, :create]
  before_action :configure_sign_up_params, only: [:create,]

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:password,:email])

  def after_sign_up_path_for(resource)
      posts_path
  end
  end
end
