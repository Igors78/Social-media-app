class FriendshipsController < ApplicationController
  before_action :set_friendship, only: %i[create destroy]
  before_action :authenticate_user!

  def create_friendship
    if @friendship.nil?
      @friendship = Friendship.new(user_id: params[:user_id], friend_id: params[:friend_id])
      if @friendship.save
        flash.notice = 'Request sent!'
        redirect_back(fallback_location: root_path)
      else
        render :new
      end
    else
      flash.notice = 'There is already a friend request pending for this user!'
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def set_friendship
    @friendship = Friendship.find_by(user_id: params[:user_id], friend_id: current_user.id) ||
                  Friendship.find_by(user_id: current_user.id, friend_id: params[:user_id])
  end

  # Only allow a list of trusted parameters through.
  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :status)
  end
end
