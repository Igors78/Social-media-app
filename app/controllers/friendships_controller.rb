class FriendshipsController < ApplicationController
  before_action :set_friendship, only: %i[create_friendship destroy_friendship]
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
      flash.notice = 'There is already a friend request pending'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy_friendship
    if @friendship
      @friendship.destroy
      flash.notice = 'Friendship has been deleted'
    else
      flash.alert = 'Error'
    end
    redirect_back(fallback_location: root_path)
  end

  def accept_request
    @friendship = Friendship.find_by(user_id: params[:user_id],
                                     friend_id: params[:friend_id])
    @friendship.update(status: true)
    redirect_back(fallback_location: root_path)
  end

  private

  def set_friendship
    @friendship = Friendship.find_by(user_id: params[:user_id],
                                     friend_id: params[:friend_id]) ||
                  Friendship.find_by(user_id: params[:friend_id],
                                     friend_id: params[:user_id])
  end

  # Only allow a list of trusted parameters through.
  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :status)
  end
end
