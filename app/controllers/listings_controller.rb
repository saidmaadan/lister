class ListingsController < ApplicationController
	before_action :require_signin, except: [:index, :show, :list, :search]
	#before_action :correct_user, only: [:edit, :update]
  before_action :require_admin, only: [:destroy]

  def search
    if params[:search].present?
      @listings = Listing.search(params[:search])
    else
      @listings = Listing.order("created_at DESC").limit(4)
    end
  end

	def index
		@listings = Listing.recently_added.limit(4)
	end

	def list
		if params[:search].present?
	    @listings = Listing.near(params[:search], 50, :order => :distance)
	  else
			@listings = Listing.recently_added
		end
	end
	

	def show
		@listing = Listing.friendly.find(params[:id])
		@amenities = @listing.amenities
	end
	
	def edit
		@listing = Listing.friendly.find(params[:id])
	end

	def update
		@listing = Listing.friendly.find(params[:id])
		if @listing.update(listing_params)
			redirect_to @listing, notice: "Listing successfully updated"
		else
			render :edit
		end
	end

	def new
		@listing = Listing.new
	end

	def create
		@listing = current_user.listings.build(listing_params)
		#@listing = Listing.new(listing_params)
		if @listing.save
			redirect_to @listing, notice: "Your listing successfully created"
		else
			render :new
		end
	end

	def destroy
		@listing = Listing.friendly.find(params[:id])
		@listing.destroy
		redirect_to listings_url, alert: "Listing successfully deleted"
	end

	private

	def listing_params
		params.require(:listing).permit(:title, :summary, :accomodate, :address, :home_type, :pricing, :apartment_type, :bedroom, :bathroom, :contact_name, :company_name, :phone, :website_url, :user_type, :info, :upload, :user_id, :latitude, :longitude, :amenity_ids => [])
	end

	def correct_user
  	unless @listing = current_user.listings.find_by(id: params[:id])
  	redirect_to listings_url, alert: "Unauthorized access!"
		end
	end
end
