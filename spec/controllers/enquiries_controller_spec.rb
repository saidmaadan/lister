require 'rails_helper'

RSpec.describe EnquiriesController, :type => :controller do

	describe "Viewing a list of enquiries" do
  
  it "shows the enquiries for a specific listing" do
    listing1 = Listing.create(listing_attributes(name: "Greg Brown"))
    enquiry1 = listing1.enquiries.create(enquiry_attributes(name: "Booby"))
    enquiry2 = listing1.enquiries.create(enquiry_attributes(name: "Emy"))


    listing2 = Listing.create(listing_attributes(name: "Cos Brown"))
    enquiry3 = listing2.enquiries.create(enquiry_attributes(name: "said"))
    
    visit listing_enquiries_url(listing1)
        
    expect(page).to have_text(enquiry1.name)
    expect(page).to have_text(enquiry2.name)
    expect(page).not_to have_text(enquiry3.name)
  end
end
