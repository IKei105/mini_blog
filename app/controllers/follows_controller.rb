class FollowsController < ApplicationController
  def create
    follow_user = User.find(params[:follow_user_id])
    return if current_user == follow_user

    current_user.follows.create(follow_user: follow_user)
    redirect_to request.referer || root_path
  end

  def destroy
    follow = current_user.follows.find_by(follow_user_id: params[:id])
    follow&.destroy
    redirect_to request.referer || root_path
  end
end
