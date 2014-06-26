class EnquiriesController < ApplicationController
	before_action :set_listing

	def index
    @enquiries = @listing.enquiries
  end

  def new
    @enquiry = @listing.enquiries.new
  end

  def create
    @enquiry = @listing.enquiries.new(enquiry_params)
    if @enquiry.save
      redirect_to listing_enquiries_path(@listing),
        notice: "Thanks for making enquiry! I'll get back to you as soon as possible"
    else
      render :new
    end
  end

private

  def enquiry_params
    params.require(:enquiry).permit(:name, :email, :comment)
  end

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

end
