require 'rails_helper'

RSpec.describe Enquiry, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe "enquiry" do

  it "belongs to a listing" do
    listing = Listing.create(listing_attributes)

    listing = listing.enquiries.new(review_attributes)

    expect(enquiry.listing).to eq(listing)
  end

  it "with example attributes is valid" do
    enquiry = Enquiry.new(enquiry_attributes)

    expect(enquiry.valid?).to be_true
  end

  it "requires a name" do
    enquiry = Enquiry.new(name: "")

    enquiry.valid?

    expect(enquiry.errors[:name].any?).to be_true
  end

  it "requires a comment" do
    enquiry = Enquiry.new(comment: "")

    enquiry.valid?
    
    expect(enquiry.errors[:comment].any?).to be_true
  end

  it "requires a comment over 3 characters" do
    enquiry = Enquiry.new(comment: "X" * 3)

    enquiry.valid?

    expect(enquiry.errors[:comment].any?).to be_true
  end
end
end
