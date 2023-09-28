class Admin::PostsController < ApplicationController
 before_action :authenticate_admin!
  def show
   
    @post = Post.find(params[:id])
  end
   def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_draft_path(params[:id])
  end
end
