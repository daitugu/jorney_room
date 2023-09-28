class Member::BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create

    bookmark = current_user.bookmarks.build(bookmark_params)
    post = bookmark.post

      bookmark.save!
      redirect_to posts_path(post), notice: "お気に入りに登録しました。"
  end



  def destroy
    bookmark = Bookmark.find(params[:id])
    post = bookmark.post
    bookmark.destroy!
      redirect_to posts_path(post), notice: "お気に入り登録を解除しました。"
  end

  def bookmarks_index
    @user = User.find(params[:id])
    @bookmarks = @user.bookmarks
  end

  private
  def bookmark_params
    params.permit(:post_id)
  end
end
