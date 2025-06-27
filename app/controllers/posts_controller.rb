class PostsController < ApplicationController
  def index
    @posts = Post.order(created_at: :desc)
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path # 成功したらルートへ移動
    else
      flash[:alert] = "投稿に失敗しました"
      redirect_to root_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:content) 
  end
end
