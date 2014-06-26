class ReviewsController < ApplicationController

	def index
		@user = User.find(params[:user_id])
		@reviews = @user.reviews 
	end
end
