require 'rails_helper'

RSpec.describe ListingsController, :type => :controller do

	describe "Viewing the listing" do
  
   it "shows the listingss" do
	    listing1 = Listing.create(title: "Private Room",
	                          summary: "Full furnished private room",
	                          pricing: 850.00,
	                          address: '18st Austin TX!',
	                          home_type: 'apartment')

	    listing2 = Listing.create(title: "Entire Home",
	                          summary: "Fully furnished entire apartment home",
	                          pricing: 1250.00,
	                          address: '56st Austin TX!',
	                          home_type: 'appartment')

	    listing3 = Listing.create(title: "Shared Room",
	                          summary: " Unfurnished shared room",
	                          pricing: 450.00,
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

  describe "Creating listing" do 
  it "saves the listing and shows the new listing's details" do    
    visit listings_url
    
    click_link 'Add Listing'
    
    expect(current_path).to eq(new_listing_path)
		
    fill_in "listing_title", with: "New Listing"
    fill_in "listing_summary", with: "Fully furnished entire apartment home"
    fill_in "listing_address", with: "Austin, TX"
    fill_in "listing_pricing", with: "850.00"
    
    click_button 'Create Listing'

    expect(current_path).to eq(listing_path(Listing.last))   
    
    expect(page).to have_text('New Listing Title')
  end
end

	describe "displaying listing's details page" do
	  
	  it "shows the listing's details" do
	    listing = Listing.create(listing_attributes)
	                          
	    visit listing_url(listing)
	    
	    expect(page).to have_text(listing.title)
	    expect(page).to have_text(listing.summary)
	    expect(page).to have_text(listing.address)
	    expect(page).to have_text(listing.pricing)
	  end
	end

	describe "Navigating listings" do

	  it "allows navigation from the detail page to the listing page" do
	    listing = Listing.create(listing_attributes)
	                          
	    visit listing_url(listing)
	        
	    click_link "All Listings"
	    
	    expect(current_path).to eq(listings_path)
	  end
	  
	  it "allows navigation from the listing page to the detail page" do
	    listing = Listing.create(listing_attributes)
	                          
	    visit listings_url
	        
	    click_link listing.title
	    
	    expect(current_path).to eq(listing_path(listing))
	  end 
  end

  describe "Edit Listing" do
  
	  it "updates the listing and shows the listing's updated details" do
	    listing = Listing.create(listing_attributes)
	    
	    visit listing_url(listing)
	    
	    click_link 'Edit'
	    
	    expect(current_path).to eq(edit_listing_path(listing))
	        
	    expect(find_field('listing_title').value).to eq(listing.title)
			
	    fill_in "Title", with: "Updated Listing Title"
	    
	    click_button "Update Title"
	    
	    expect(current_path).to eq(listing_path(listing))

	    expect(page).to have_text("Updated Listing Title")
	  end
	end

	describe "Delete listing" do 
	  it "destroys the listing and shows the event listing" do
	    listing = Listing.create(listing_attributes)
	    
	    visit listing_path(listing)
	    
	    click_link 'Delete'
	    
	    expect(current_path).to eq(listings_path)
	    expect(page).not_to have_text(listing.title)
	  end
	end

	describe "set validation" do 	

		it "requires a title" do
		  listing = Listing.new(title: "")

		  listing.valid?

		  expect(listing.errors[:title].any?).to be_true
		end

		it "requires a listing summary" do
		  listing = Listing.new(summary: "")

			  listing.valid?

			  expect(listing.errors[:summary].any?).to be_true
		end

		it "accepts a summary up to 500 characters" do
		  listing = Listing.new(summary: "X" * 501)

				  listing.valid?

				  expect(listing.errors[:summary].any?).to be_true
			end

		it "requires a listing address" do
			  listing = Listing.new(address: "")

				  listing.valid?

				  expect(listing.errors[:address].any?).to be_true
			end

		it "rejects a $0 listing price" do

		  listing = Listing.new(pricing: 0.00)

			  listing.valid?

			  expect(listing.errors[:pricing].any?).to be_true
		end


		it "rejects a negative listing price" do
		  listing = Listing.new(pricing: -10.00)

		  listing.valid?

		  expect(listing.errors[:pricing].any?).to be_true
		end

		it "accepts properly formatted website URLs" do
		  sites = %w[http://example.com https://example]
		  sites.each do |site|
		    listing = Listing.new(website_url: site)
		    listing.valid?
		    expect(listing.errors[:website_url].any?).to be_false
		  end
		end

		it "rejects improperly formatted website URLs" do
		  sites = %w[example.com http examplehttp]
		  sites.each do |site|
		    listing = Listing.new(website_url: site)
		    listing.valid?
		    expect(listing.errors[:website_url].any?).to be_true
		  end
		end
	end
end
