class BlogsController < ApplicationController
	before_action :require_signin, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  #before_action :require_admin, only: [:destroy]

  def index
  	@blogs = Blog.all 
  end

  def show
		@blog = Blog.friendly.find(params[:id])
	end

	def edit
		@blog = Blog.friendly.find(params[:id])
	end

	def update
		@blog = Blog.friendly.find(params[:id])
		if @blog.update(blog_params)
			redirect_to @blog, notice: "Your post successfully updated"
		else
			render :edit
		end
	end

  def new
  	@blog = Blog.new
  end


  def create
  	#@blog = Blog.new(blog_params)
  	@blog = current_user.blogs.build(blog_params)
    if @blog.save
      #flash[:success] = "Blog created!"
      redirect_to blogs_path notice: "Blog created!"
    else
      render :new
    end
  end

  def destroy
  	@blog = Blog.friendly.find(params[:id])
  	@blog.destroy
  	redirect_to blogs_path, alert: "Post successfully deleted!"
  end

  private

  def blog_params
  	params.require(:blog).permit(:title, :content, :user_id)
  end

  def correct_user
  	unless @blog = current_user.blogs.find_by(id: params[:id])
  	redirect_to blogs_path, alert: "Unauthorized access!"
  end
end
end
