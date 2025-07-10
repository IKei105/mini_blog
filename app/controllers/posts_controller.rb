class PostsController < ApplicationController
  POSTS_PER_PAGE = 30

  before_action :set_following_user_ids, only: [:index, :create, :following]

  def index
    @posts = fetch_posts
    @post = Post.new
  end

  def create
    unless current_user
      flash[:alert] = "ログインしてください"
      redirect_to new_user_session_path
      return
    end

    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_back fallback_location: root_path
    else
      flash[:alert] = "投稿に失敗しました"
      @posts = fetch_posts
      render :index
    end
  end

  def following
    @post = Post.new
    @posts = Post.includes(:user)
               .where(user_id: current_user.followings.select(:id))
               .order(created_at: :desc)
               .paginate(page: params[:page])
    render :index
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def fetch_posts
    Post.includes(:user).order(created_at: :desc).paginate(page: params[:page], per_page: POSTS_PER_PAGE)
  end

  def set_following_user_ids
    @following_user_ids = user_signed_in? ? current_user.followings.pluck(:id) : []
  end
end
