class ApplicationController < ActionController::Base
    #before_action :authenticate_user!, except: [:top]
private
    def authenticate_user_or_admin!
        
if admin_signed_in? || user_signed_in
else 
    redirect_to root_path
end
    end
    #before_action :configure_permitted_parameters, if: :devise_controller?
end
