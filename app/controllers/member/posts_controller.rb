class Member::PostsController < ApplicationController
  before_action :authenticate_user!,except: [:index]
  def new
    @post = Post.new
  end

  def create
    @post= Post.new(post_params)
    @post.user_id = current_user.id
   if params[:draft]
    if @post.update(is_opened: false)
        redirect_to draft_path
    else
        render :new
    end


   else
    @post.is_opened = true
   if @post.save
    redirect_to posts_path
   else
      render :new
   end
   end
  end

  def edit
  @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if params[:publicize_draft]
         @post.is_opened = true
      if @post.save(context: :publicize)
        redirect_to posts_path(@post.id)
      else
       @post.is_opened = false
        render :edit
      end
    elsif params[:update_post]
      @post.attributes = post_params
      if @post.save(context: :publicize)
        redirect_to post_path(@post.id)
      else
        render :edit
      end

    else
      if @post.update(post_params)
        redirect_to post_path(@post.id)
      else
        render :edit
      end
    end
  end

  def draft
   @post = current_user.posts.where(is_opened: false).page(params[:page])

  end


  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def index
    if params[:user_id]
      @post = Post.where(is_opened: true, user_id: params[:user_id]).page(params[:page])
    else
      @post = Post.where(is_opened: true).page(params[:page])
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:tag_id, :image,  :thoughts, :location, :lodging_fee, :room_type, :is_opened)
  end
end
