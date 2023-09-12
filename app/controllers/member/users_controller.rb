class Member::UsersController < ApplicationController
  def show
    @user = current_user

  end
  def edit
    @user = current_user
  end

  def user_params
    params.require(:user).permit()
  end
end
