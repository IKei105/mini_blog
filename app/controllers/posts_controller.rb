class PostsController < ApplicationController
  def index
    @posts = Post.order(created_at: :desc).paginate(page: params[:page], per_page: 30)
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path # 成功したらルートへ移動
    else
      flash[:alert] = "投稿に失敗しました"
      @posts = Post.order(created_at: :desc).paginate(page: params[:page], per_page: 30)  # リダイレクトすると入力値が消えるのでrender
      render :index
    end
  end

  private

  def post_params
    params.require(:post).permit(:content) 
  end
end
