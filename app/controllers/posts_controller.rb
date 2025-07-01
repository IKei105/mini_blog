class PostsController < ApplicationController
  def index
    @posts = Post.includes(:user).order(created_at: :desc).paginate(page: params[:page], per_page: 30)
    @post = Post.new
  end

  def create
    unless current_user
      flash[:alert] = "ログインしてください"
      redirect_to new_user_session_path
      return
    end

    # if current_user.nil?
    #   flash[:alert] = "ログインしてください"
    #   redirect_to root_path
    #   return
    # end

    @post = current_user.posts.build(post_params) # ログイン中のユーザーの情報を取得して、それを入れ込んでいる
    if @post.save
      redirect_to root_path # 成功したらルートへ移動
    else
      flash[:alert] = "投稿に失敗しました"
      @posts = Post.includes(:user).order(created_at: :desc).paginate(page: params[:page], per_page: 30)  # リダイレクトすると入力値が消えるのでrender
      render :index
    end
  end

  private

  def post_params
    params.require(:post).permit(:content) 
  end
end
