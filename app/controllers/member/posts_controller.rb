class Member::PostsController < ApplicationController
  before_action :authenticate_user!,except: [:index]
  def new
    @post = Post.new
  end

  def create
    @post= Post.new(post_params)
    @post.user_id = current_user.id
   if params[:draft]
     @post.is_opened = false
   else
    @post.is_opened = true
   end
    input_tags = params[:name].split
    new_tags = []
    input_tags.each do |tag| # 新しいタグをモデルに追加
      new_tag = Tag.find_or_create_by(name: tag)
      new_tags.push(new_tag.id)
      #tags << new_tag
   end
   if @post.save
    new_tags.each do |tag|
    Tagmap.create(:post_id => @post.id, :tag_id =>tag)
   end
    redirect_to posts_path
   else
      render :new
   end
  end

  def edit
  @post = Post.find(params[:id])
  end

  def detail
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
      Tagmap.where(:post_id =>@post.id).destroy_all
      input_tags = params[:name].split
      new_tags = []
      input_tags.each do |tag|
        new_tag = Tag.find_or_create_by(name: tag)
        new_tags.push(new_tag.id)
      end
      if @post.save(context: :publicize)
        new_tags.each do |tag|
         Tagmap.create(:post_id => @post.id, :tag_id =>tag)
        end
        redirect_to post_path(@post.id)
      else
        render :edit
      end
    else
      Tagmap.where(:post_id =>@post.id).destroy_all
      input_tags = params[:name].split
      new_tags = []
      input_tags.each do |tag|
        new_tag = Tag.find_or_create_by(name: tag)
        new_tags.push(new_tag.id)
      end
      if @post.update(post_params)
        new_tags.each do |tag|
         Tagmap.create(:post_id => @post.id, :tag_id =>tag)
        end
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
    #params.require(:post).permit( :image,  :thoughts, :location, :lodging_fee, :room_type)
    params.permit( :image,  :thoughts, :location, :lodging_fee, :room_type)
  end
end
