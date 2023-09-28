class Member::LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    post = Post.find(params[:post_id])
    like = current_user.likes.new(post_image_id: post_image.id)
    like.save
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:post_id])
    like = current_user.likes.new.find_by(post_image_id: post_image.id)
    like.destroy
    redirect_to post_path(post)
  end
end

