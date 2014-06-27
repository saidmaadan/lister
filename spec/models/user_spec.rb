require 'rails_helper'

RSpec.describe User, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe "A user" do

	  it "requires a name" do
	    user = User.new(name: "")
	    
	    user.valid?

	    expect(user.errors[:name].any?).to be_true
	  end

	  it "requires an email" do
	    user = User.new(email: "")

	    user.valid?

	    expect(user.errors[:email].any?).to be_true
	  end

	  it "accepts properly formatted email addresses" do
	    emails = %w[agent@example.com first.last@example.com]
	    emails.each do |email|
	      user = User.new(email: email)
	      user.valid?
	      expect(user.errors[:email].any?).to be_false
	    end
	  end

	  it "rejects improperly formatted email addresses" do
	    emails = %w[@ agent@ @example.com]
	    emails.each do |email|
	      user = User.new(email: email)
	      user.valid?
	      expect(user.errors[:email].any?).to be_true
	    end
	  end

	  it "requires a unique, case insensitive email address" do
	    user1 = User.create!(user_attributes)

	    user2 = User.new(email: user1.email.upcase)
	    user2.valid?
	    expect(user2.errors[:email].first).to eq("has already been taken")
	  end

	  it "is valid with example attributes" do
	    user = User.new(user_attributes)

	    expect(user.valid?).to be_true
	  end

	  it "requires a password" do
	    user = User.new(password: "")

	    user.valid?

	    expect(user.errors[:password].any?).to be_true
	  end

	  it "requires a password confirmation when a password is present" do
	    user = User.new(password: "hidden", password_confirmation: "")

	    user.valid?

	    expect(user.errors[:password_confirmation].any?).to be_true
	  end

	  it "requires the password to match the password confirmation" do
	    user = User.new(password: "hidden", password_confirmation: "nomatch")

	    user.valid?

	    expect(user.errors[:password_confirmation].first).to eq("doesn't match Password")
	  end

	  it "requires a password and matching password confirmation when creating" do
	    user = User.create!(user_attributes(password: "hidden", password_confirmation: "hidden"))

	    expect(user.valid?).to be_true
	  end

	  it "does not require a password when updating" do
	    user = User.create!(user_attributes)

	    user.password = ""

	    expect(user.valid?).to be_true
	  end

	  it "automatically encrypts the password into the password_digest attribute" do
	    user = User.new(password: "hidden")

	    expect(user.password_digest).to be_present
	  end
	end

	describe "authenticate" do
	  before do
	    @user = User.create!(user_attributes)
	  end

	  it "returns false if the email does not match" do
	    expect(User.authenticate("nomatch", @user.password)).to be_false
	  end

	  it "returns false if the password does not match" do
	    expect(User.authenticate(@user.email, "nomatch")).to be_false
	  end

	  it "returns the user if the email and password match" do
	    expect(User.authenticate(@user.email, @user.password)).to eq(@user)
	  end
end
end
