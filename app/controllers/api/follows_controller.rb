class Api::FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    follow_user = User.find(params[:follow_user_id]) # bodyから取得

    current_user.follow_users << follow_user unless current_user.follow_users.include?(follow_user)
    render json: { status: 'ok' }
  rescue => e
    render json: { status: 'error', message: 'エラーが発生しました' }, status: :unprocessable_entity
  end

  def destroy
    follow_user = User.find(params[:id])

    current_user.follow_users.destroy(follow_user)
    render json: { status: 'ok' }
  rescue => e
    render json: { status: 'error', message: 'エラーが発生しました' }, status: :unprocessable_entity
  end
end
