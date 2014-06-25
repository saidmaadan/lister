require 'rails_helper'

RSpec.describe ListingsController, :type => :controller do

	describe "Viewing the listing" do
  
	   it "shows the listingss" do
		    listing1 = Listing.create(title: "Private Room",
		                          summary: "Full furnished private room",
		                          price: 850.00,
		                          address: '18st Austin TX!',
		                          home_type: 'apartment')

		    listing2 = Listing.create(title: "Entire Home",
		                          summary: "Fully furnished entire apartment home",
		                          price: 1250.00,
		                          address: '56st Austin TX!',
		                          home_type: 'appartment')

		    listing3 = Listing.create(title: "Shared Room",
		                          summary: " Unfurnished shared room",
		                          price: 450.00,
		                          address: '42st Austin TX!',
		                          home_type: 'breakfast')
		    visit listings_url
		    
		    expect(page).to have_text("3 Listings")
		    expect(page).to have_text(listing1.title)
		    expect(page).to have_text(listing2.title)
		    expect(page).to have_text(listing3.title)

		    expect(page).to have_text(listing1.summary)
		    expect(page).to have_text(listing1.address)
		    expect(page).to have_text(listing1.home_type)
		    expect(page).to have_text("$850.00")
		  end
  end

end
