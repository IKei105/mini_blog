class FollowsController < ApplicationController
  def create
    follow_user = User.find(params[:follow_user_id])
    current_user.follows.create(follow_user: follow_user)
  end

  def destroy
  end
end
