require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ReviewsHelper. For example:
#
# describe ReviewsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ReviewsHelper, :type => :helper do
  pending "add some examples to (or delete) #{__FILE__}"

  describe "Creating a new review" do 
  it "saves the review" do    
    user = User.create(user_attributes)

    visit user_url(user)
    
    click_link 'Write Review'
    
    expect(current_path).to eq(new_user_review_path(user))
    
    fill_in "Name", with: "Greg Cos"
    select 5, :from => "review_stars"
    fill_in "Comment", with: "Greg is great guy!"
            
    click_button 'Post Review'
  
    expect(current_path).to eq(user_reviews_path(user))
    
    expect(page).to have_text("Thanks for your review!")
  end
  
  it "does not save the review if it's invalid" do
    user = User.create(user_attributes)

    visit new_user_review_url(user)
    
    expect { 
      click_button 'Post Review' 
    }.not_to change(Review, :count)
        
    expect(page).to have_text('error')
  end
end
end
