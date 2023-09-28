class Member::UsersController < ApplicationController
    before_action :authenticate_user!
  def mypage
    @user = current_user
    @post = @user.posts.page(params[:page])
    @bookmarks = current_user.bookmarks
  end

  def show
    @user = User.find(params[:id])
    @post = @user.posts.page(params[:page])
    @bookmarks = @user.bookmarks
  end

  def edit
    user = User.find(params[:id])
  unless user.id == current_user.id
    redirect_to posts_path
  end
    @user = current_user
  end

  def update
    user = User.find(params[:id])
  unless user.id == current_user.id
    redirect_to posts_path
  end
    @user = current_user
    @user.update(user_params)
    redirect_to user_path(current_user)
  end

  def withdraw
    @user = current_user
  end

  def leave
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit(:name,:email,:password)
  end

end
