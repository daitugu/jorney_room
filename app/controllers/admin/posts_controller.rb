class Admin::PostsController < ApplicationController
 before_action :authenticate_admin!
  def show
    @post = Post.find(params[:id])
  end
   def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_draft_path(post.user_id)
   end

  def detail
  @post = Post.find(params[:id])
  end

  def draft

   @user  = User.find(params[:id])
   @user_posts = @user.posts.where(is_opened: true).page(params[:page])
  end
end
