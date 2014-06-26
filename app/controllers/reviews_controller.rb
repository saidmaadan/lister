class ReviewsController < ApplicationController
	before_action :require_signin
	before_action :set_user

	def index		
		@reviews = @user.reviews 
	end

	def new
		@review = @user.reviews.new
	end

	def create
	  @review = @user.reviews.new(review_params)
	  @review.user = current_user
	  if @review.save
	    redirect_to user_reviews_path(@user), 
	                  notice: "Thanks for your review!"
	  else
	    render :new
	  end
	end

	def destroy
	  @review = @user.reviews.find(params[:id])
	  @review.destroy
	  redirect_to user_reviews_path(@user), notice: "Review successfully deleted!"
	end

	private

	def review_params
	  params.require(:review).permit(:comment, :stars)
	end

	def set_user
		@user = User.find(params[:user_id])
	end
end
