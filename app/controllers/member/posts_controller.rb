class Member::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post= Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to posts_path
  end
  
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end
  
  def index
    @post = Post.all
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:tag_id, :image,  :thoughts, :location, :lodging_fee, :room_type)
  end
end
