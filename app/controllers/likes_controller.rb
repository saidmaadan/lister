class LikesController < ApplicationController
	before_action :require_signin
  before_action :set_user
  
  def create
    @likers = @user.likers
    @user.likers << current_user
    redirect_to @user, notice: "Glad you liked me!"
  end
  
  def destroy
    like = current_user.likes.find(params[:id])
    like.destroy
    redirect_to @user, notice: "Sorry you unliked me!"
  end
  
private

  def set_user
    @user = User.find(params[:user_id])
  end
end
