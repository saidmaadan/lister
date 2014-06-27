class ListingsController < ApplicationController
	before_action :require_signin, except: [:index, :show]
    before_action :require_admin, only: [:destroy]
	def index
		@listings = Listing.all
	end

	def show
		@listing = Listing.find(params[:id])
		@amenities = @listing.amenities
	end

	def edit
		@listing = Listing.find(params[:id])
	end

	def update
		@listing = Listing.find(params[:id])
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
		@listing = Listing.new(listing_params)
		if @listing.save
			redirect_to @listing, notice: "Your listing successfully created"
		else
			render :new
		end
	end

	def destroy
		@listing = Listing.find(params[:id])
		@listing.destroy
		redirect_to listings_url, alert: "Listing successfully deleted"
	end

	private

	def listing_params
		params.require(:listing).permit(:title, :summary, :accomodate, :address, :home_type, :pricing, :apartment_type, :bedroom, :bathroom, :contact_name, :company_name, :phone, :website_url, :user_type, :info, :upload, :amenity_ids => [])
	end

end
