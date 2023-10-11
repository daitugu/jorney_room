class Member::BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    bookmark = current_user.bookmarks.build(bookmark_params)
    bookmark.save!
    redirect_to posts_path(post), notice: "お気に入りに登録しました。"
  end



  def destroy
    post = Post.find(params[:id])
    current_user.bookmarks.find_by(post_id: post.id).destroy!
    redirect_to posts_path(post), notice: "お気に入り登録を解除しました。"
  end

  def bookmarks_index
    @user = User.find(params[:id])
    @bookmarks = @user.bookmarks.page(params[:page])
  end

  private
  def bookmark_params
    params.permit(:post_id)
  end
end
