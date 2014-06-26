require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

	describe "Creating a new user" do 
  it "saves the user and shows the user's profile page" do    
    visit root_url
    
    click_link 'Sign Up'
    
    expect(current_path).to eq(signup_path)
		
    fill_in "Name",  with: "Agent1"
    fill_in "Email", with: "agent@example.com"
    fill_in "Password", with: "hidden"
    fill_in "Confirm Password", with: "hidden"
    
    click_button 'Create Account'

    expect(current_path).to eq(user_path(User.last))   
    
    expect(page).to have_text('Agent1')
    expect(page).to have_text('Thanks for signing up!')
  end
  
  it "does not save the user if it's invalid" do
    visit signup_url
    
    expect { 
      click_button 'Create Account'
    }.not_to change(User, :count)
        
    expect(page).to have_text('error')
  end
end

describe "Deleting a user" do 
it "destroys the user and redirects to the home page" do
    user = User.create!(user_attributes)
    
    visit user_path(user)
    
    click_link 'Delete Account'
        
    expect(current_path).to eq(root_path)
    expect(page).to have_text('Account successfully deleted!')
    
    visit users_path
    
    expect(page).not_to have_text(user.name)
  end
end


describe "Editing a user" do
  
  it "updates the user and shows the user's updated details" do
    user = User.create!(user_attributes)
    
    visit user_url(user)
    
    click_link 'Edit Account'
    
    expect(current_path).to eq(edit_user_path(user))
        
    expect(find_field('Name').value).to eq(user.name)
		
    fill_in "Name", with: "Updated User Name"
    
    click_button "Update Account"
    
    expect(current_path).to eq(user_path(user))

    expect(page).to have_text("Updated User Name")
    expect(page).to have_text('Account successfully updated!')
  end
  
  it "does not update the user if it's invalid" do
    user = User.create!(user_attributes)
    
    visit edit_user_url(user)
    
    fill_in 'Name', with: " "
    
    click_button "Update Account"
        
    expect(page).to have_text('error')
  end 
end

describe "Viewing the list of users" do
  
  it "shows the users" do
    user1 = User.create!(user_attributes(name: "Greg", email: "greg@example.com"))
    user2 = User.create!(user_attributes(name: "Bobby",   email: "bobby@example.com"))
    user3 = User.create!(user_attributes(name: "Kathrina", email: "kgreek@example.com"))
    
    visit users_url
    
    expect(page).to have_link(user1.name)
    expect(page).to have_link(user2.name)
    expect(page).to have_link(user3.name)
  end
end


describe "Viewing a user's profile page" do
  
  it "shows the user's details" do
    user = User.create!(user_attributes)
                          
    visit user_url(user)
    
    expect(page).to have_text(user.name)
    expect(page).to have_text(user.email)
  end
  
end
 
end

