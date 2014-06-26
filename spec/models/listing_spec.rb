require 'rails_helper'

RSpec.describe Listing, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe "Listing" do
    
  
	  it "requires a title" do
	    listing = Listing.new(title: "")
	    
	    expect(listing.valid?).to be_false
	    expect(listing.errors[:title].any?).to be_true
	  end
	  
	  it "requires a listing summary" do
	    listing = Listing.new(summary: "")
	    
	    expect(listing.valid?).to be_false
	    expect(listing.errors[:summary].any?).to be_true
	  end
	  
	  it "requires a location" do
	    listing = Listing.new(address: "")
	    
	    expect(listing.valid?).to be_false
	    expect(listing.errors[:address].any?).to be_true
	  end
	  
	  it "requires a description over 24 characters" do
	    listing = Listing.new(summary: "X" * 24)
	    
	    expect(listing.valid?).to be_false
	    expect(listing.errors[:summary].any?).to be_true
	  end
	  
	  
	  it "accepts a positive price" do
	    listing = Listing.new(pricing: 850.00)

	    expect(listing.valid?).to be_false
	    expect(listing.errors[:pricing].any?).to be_true
	  end
	  
	  it "rejects a negative price" do
	    listing = Listing.new(pricing: -850.00)

	    expect(listing.valid?).to be_false
	    expect(listing.errors[:pricing].any?).to be_true
	  end
	  
	  it "with example attributes is valid" do
	    listing = Listing.new(event_attributes)
	    
	    expect(listing.valid?).to be_true
	  end
	  
	  it "has many enquiries" do
	    listing = Listing.new(listing_attributes)
	    
	    enquiry1 = listing.enquiries.new(enquiry_attributes)
	    enquiry2 = listing.enquiries.new(enquiry_attributes)
	        
	    expect(listing.enquiries).to include(enquiry1)
	    expect(listing.enquiries).to include(enquiry2)
	  end
	  
	  it "deletes associated enquiriess" do
	    listing = listing.create(listing_attributes)
	    
	    listing.enquiries.create(enquiry_attributes)
	    
	    expect { 
	      listing.destroy
	    }.to change(Enquiries, :count).by(-1)
	  end
	end

end
