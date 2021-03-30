class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id], status: params[:status])
    if @friendship.save
      flash[:notice] = "Friend request sent!"
      redirect_to users_path
    else
      flash[:notice] = "Error sending friend request"
      redirect_to users_path
    end
  end

  def update
    @friendship = Friendship.find(params[:id])
    if @friendship.update(status: params[:status])
      @inverse_friendship = current_user.friendships.build(friend_id: @friendship[:user_id], status: true)
      if @inverse_friendship.save
        flash[:notice] = "Friendship accepted"
        redirect_to users_path
      else
        flash[:notice] = "Error creating inverse friend :( "
        render "users#show"
      end
    else
      flash[:notice] = "Could not accept friend request"
      render "users#show"
    end
  end

  def destroy
  end
end
