class FriendshipsController < ApplicationController
  
  def index
    @sent_friendship_requests = current_user.friendships.where(status: false)
    @received_friendship_requests = current_user.inverse_friendships.where(status: false)
    @real_friends = current_user.friendships.where(status: true)
    friends_ids = current_user.friendships.map {|friend| friend[:friend_id] }
    friends_ids << current_user.id
    @non_friends = User.where.not(:id => friends_ids)
  end
  
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id], status: params[:status])
    if @friendship.save
      flash[:notice] = 'Friend request sent!'
      redirect_to friendships_path
    else
      flash[:notice] = 'Error sending friend request'
      redirect_to friendships_path
    end
  end

  def update
    @friendship = Friendship.find(params[:id])

    if @friendship.update(status: params[:status])
      @inverse_friendship = current_user.friendships.build(friend_id: @friendship[:user_id], status: true)

      if @inverse_friendship.save
        flash[:notice] = 'Friendship accepted'
        redirect_to friendships_path
      else
        flash[:notice] = 'Error creating inverse friend :( '
        render 'users#show'
      end

    else
      flash[:notice] = 'Could not accept friend request'
      render 'users#show'
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @inverse_friendship = Friendship.where(user_id: @friendship.friend_id, friend_id: @friendship.user_id)

    if (current_user.id == @friendship.user_id || current_user.id == @friendship.friend_id)
      @inverse_friendship = Friendship.find_by user_id: @friendship.friend_id, friend_id: @friendship.user_id
      @friendship.destroy
    end

    unless @inverse_friendship.nil?
      @inverse_friendship.destroy
    end

    redirect_to friendships_path

  end
end
