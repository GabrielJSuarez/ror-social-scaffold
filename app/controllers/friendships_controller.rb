class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friendships = current_user.friends
    @pending_friends = current_user.pending_friends
    @friend_requests = current_user.friend_requests
  end

  def create
    @friendship = current_user.friendships.new(friend_id: params[:friend_id])
    if @friendship.save
      redirect_to users_path, notice: 'Friendship request sent'
    else
      redirect_to users_path, alert: 'Can\'t send friend request'
    end
  end

  def update
    @user = User.find(params[:id])
    @friendship = current_user.inverted_friendships.confirm_friend(@user)
    redirect_to users_path, notice: 'Friend Added'
  end

  def destroy
    @user = User.find(params[:id])
    @friendship = current_user.inverted_friendships.reject_friend(@user)
    redirect_to users_path, notice: 'Friend request rejected'
  end
end
