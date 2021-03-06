class RelationshipsController < ApplicationController
  before_action :set_user

  def create
    # @user = User.find(params[:user_id])
    # @user = User.find(params[:user_id])
    # following = current_user.follow(@user)
    if current_user.follow(@user)
      flash[:succes] = 'フォローしました'
      redirect_to request.referer
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
      redirect_to request.referer
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      flash[:succes] = 'フォローを解除しました'
      redirect_to request.referer
    else
      lash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      redirect_to request.referer
    end
  end

  private
  def set_user
    @user = User.find(params[:following_id])
  end
end