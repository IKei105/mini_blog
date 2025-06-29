class ProfilesController < ApplicationController

  def new
    @profile = Profile.new
  end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to root_path
    else
      flash.now[:alert] = "正しく入力してくださいよ"
      logger.debug @profile.errors.full_messages.join(", ")
      render :new
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:introduction, :blog_url)
  end

end
