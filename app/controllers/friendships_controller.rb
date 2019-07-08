class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      flash[:notice] = "Successfully created friendship"
      redirect_to dashboard_path
    else
      flash[:error] = "Unable to add friend."
      redirect_to dashboard_path
    end
  end

  def remove
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Successfully removed friendship."
    redirect_to dashboard_path
  end
end