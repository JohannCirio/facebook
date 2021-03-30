class UsersController < ApplicationController
  def index
    @users = User.where.not(id: current_user[:id])
    @sent_friendship_requests = current_user.friendships.where(status: false)
    @received_friendship_requests = current_user.inverse_friendships.where(status: false)
    @friends = current_user.friendships.where(status: true)
  end
end
