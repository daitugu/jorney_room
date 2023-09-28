class Admin::UsersController < ApplicationController
   before_action :authenticate_admin!
 

  def draft
  @user  = User.find(params[:id])
  @user_posts = @user.posts.where(is_opened: true).page(params[:page])
  end
  

end