class UsersController < ApplicationController
	before_action :require_signin, except: [:new, :create]
  before_action :require_correct_user, only: [:edit, :update]
  before_action :require_admin, only: [:destroy]


	
	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
    @is_admin = current_user && current_user.id == @user.id
		@enquiries = @user.enquiries
		@reviews = @user.reviews
		# @likers = @user.likers
  #   # @liked = @user.liked
		# if current_user
  #     @current_like = current_user.likes.find_by(user_id: @user.id)
  #   end
    
	end

	def new
		@user = User.new
    @review = @user.reviews.new
	end

	def create
    @user = User.new(user_params)
    if @user.save
    	session[:user_id] = @user.id
      redirect_to @user, notice: "Thanks for signing up!"
    else
      render :new
    end 
  end

  def profile
    @user = User.find(params[:id])
  end

  def edit
  end

  
  
  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Account successfully updated!"
    else
      render :edit
    end
  end
  
  def destroy
  	@user = User.find(params[:id])
    @user.destroy
    # session[:user_id] = nil
    redirect_to root_url, alert: "Account successfully deleted!"
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :username, :sex, :birthdate, :phone_number, :where_you_live, :info, :school, :work, :marital_status, :video,:avatar)
  end

  def require_correct_user
    @user = User.find(params[:id])
    unless current_user?(@user)
      redirect_to root_url 
    end
  end
end
