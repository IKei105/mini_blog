class FollowsController < ApplicationController
  def create
    follow_user = User.find(params[:follow_user_id])
    if current_user == follow_user
    return
  end
  current_user.follows.create(follow_user: follow_user)
  end

  def destroy
    follow_user = current_user.follows.find_by(follow_user_id: params[:id])
    follow_user.destroy if follow_user
    redirect_to root_path 
  end
end
