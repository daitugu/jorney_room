class Member::TagsController < ApplicationController
   before_action :authenticate_admin!
  def new
    @post = Post.new
  end

  def create
    input_tags = tag_params.split    # tag_paramsをsplitメソッドを用いて配列に変換する
    @post.create_tags(input_tags)   # create_tagsはtopic.rbにメソッドを記載している
    @post.save
    redirect_to posts_path          # こちらはindexに遷移するように設定している
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    input_tags = tag_params.split
    @post.update_tags(input_tags) # udpate_tagsはtopic.rbに記述している
    redirect_to request.referer    # editページに戻るようにしている
  end

  def destroy
  end

  private
    def tag_params # tagに関するストロングパラメータ
      params.require(:post).permit(:name)
    end
end