class FollowsController < ApplicationController
  before_action :set_user, only: [:index, :followers, :create, :destroy]

  def index
  	@follows = @user.follows.where.not(target_user_id: current_user.id)
  end

  def followers
  	@followers = @user.followers.where.not(user_id: current_user.id)
  end

  def create
  	target_user_id = params[:id]
  	unless @user.is_follow?(target_user_id)
  		@user.follows << Follow.new(target_user_id: target_user_id)
  		@user.save!
  	end
  	redirect_to user_path(target_user_id)
  rescue
  	redirect_to user_path(target_user_id), notice: "フォローに失敗しました"
  end

  def destroy
  	target_user_id = params[:id]
  	follow = @user.follows.find_by(target_user_id: target_user_id)
  	follow.destroy if follow.present?
  	redirect_to user_path(target_user_id)
  rescue
  	redirect_to user_path(target_user_id), notice: "フォロー解除に失敗しました"
  end

private

  def set_user
    @user = User.find(params[:user_id])
  end
end
