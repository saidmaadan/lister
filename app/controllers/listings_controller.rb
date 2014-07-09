class ListingsController < ApplicationController
	before_action :require_signin, except: [:index, :show, :list]
	before_action :correct_user, only: [:edit, :update]
    before_action :require_admin, only: [:destroy]


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
		@listing = Listing.find(params[:id])
		@amenities = @listing.amenities
		@hash = Gmaps4rails.build_markers(@listings) do |listing, marker|
		  marker.lat listing.latitude
		  marker.lng listing.longitude
		  marker.infowindow listing.address
		  marker.picture({
		  	'url' => 'https://addons.cdn.mozilla.net/img/uploads/addon_icons/13/13028-64.png',
		  	width => 32,
		  	'height' => 32
		  	})
		  marker.json({address: listing.address})
		end
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
		@listing = current_user.listings.build(listing_params)
		#@listing = Listing.new(listing_params)
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
		params.require(:listing).permit(:title, :summary, :accomodate, :address, :home_type, :pricing, :apartment_type, :bedroom, :bathroom, :contact_name, :company_name, :phone, :website_url, :user_type, :info, :upload, :user_id, :latitude, :longitude, :amenity_ids => [])
	end

	def correct_user
  	unless @listing = current_user.listings.find_by(id: params[:id])
  	redirect_to listings_url, alert: "Unauthorized access!"
	end
end
end
