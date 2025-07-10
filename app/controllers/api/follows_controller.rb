class Api::FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:create, :destroy]

  def create
    if current_user.followings.exists?(@user.id)
      render json: { status: 'ok', message: 'すでにフォローしています' }
    else
      Follow.create!(follower: current_user, followed: @user)
      render json: { status: 'ok' }
    end
  end


  def destroy
    current_user.followings.destroy(@user)
    render json: { status: 'ok' }
  end

  private

  def set_user
    @user = User.find_by(id: params[:follow_user_id] || params[:id])
    unless @user
      render json: { status: 'error', message: 'ユーザーが見つかりません' }, status: :not_found
      return
    end
  end
end
