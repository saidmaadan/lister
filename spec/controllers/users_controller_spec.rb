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
    
    sign_in(user)                      
    visit user_url(user)
    
    expect(page).to have_text(user.name)
    expect(page).to have_text(user.email)
  end  
end

describe "Display the list of users" do

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

describe "Creating a new user" do 
  it "saves the user and shows the user's profile page" do    
    visit root_url

    click_link 'Sign Up'

    expect(current_path).to eq(signup_path)

    fill_in "Name",  with: "Agent1"
    fill_in "Email", with: "ahent@example.com"
    fill_in "Password", with: "hidden"
    fill_in "Confirm Password", with: "hidden"
    
    click_button 'Create User'

    expect(current_path).to eq(user_path(User.last))   

    expect(page).to have_text('Agent1')
    expect(page).to have_text('Thanks for signing up!')
  end

  it "does not save the user if it's invalid" do
    visit signup_url

    expect { 
      click_button 'Create User'
    }.not_to change(User, :count)

    expect(page).to have_text('error')
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

describe "Signing in" do

  it "prompts for an email and password" do
    visit root_url

    click_link 'Sign In'

    expect(current_path).to eq(new_session_path)

    expect(page).to have_field("Email")
    expect(page).to have_field("Password")
  end
end

	it "signs in the user if the email/password combination is valid" do
	  user = User.create!(user_attributes)

	  visit root_url

	  click_link 'Sign In'

	  fill_in "Email", with: user.email
	  fill_in "Password", with: user.password

	  click_button 'Sign In'

	  expect(current_path).to eq(user_path(user))   

	  expect(page).to have_text("Welcome back, #{user.name}!")
	end

	it "does not sign in the user if the email/password combination is invalid" do
	  user = User.create!(user_attributes)

	  visit root_url

	  click_link 'Sign In'

	  fill_in "Email", with: user.email
	  fill_in "Password", with: "no match"

	  click_button 'Sign In'

	  expect(page).to have_text('Invalid')
	end

	it "signs in the user if the email/password combination is valid" do
 
	  expect(page).to have_link(user.name)
	  expect(page).not_to have_link('Sign In')
	  expect(page).not_to have_link('Sign Up')
end

	it "does not sign in the user if the email/password combination is invalid" do
	  

	  expect(page).not_to have_link(user.name)
	  expect(page).to have_link('Sign In')
	  expect(page).to have_link('Sign Up')
	end

	describe "Signing out" do

	  it "removes the user id from the session" do
	    user = User.create!(user_attributes)

	    sign_in(user)

	    click_link 'Sign Out'

	    expect(page).to have_text("signed out")
	    expect(page).not_to have_link('Sign Out')
	    expect(page).to have_link('Sign In')
	  end

	  it "automatically signs out that user" do
		  user = User.create!(user_attributes)

		  sign_in(user)

		  visit user_path(user)

		  click_link 'Delete Account'

		  expect(page).to have_link('Sign In')
		  expect(page).not_to have_link('Sign Out')
		end
	end

	describe UsersController do

	  before do
	    @user = User.create!(user_attributes)
	  end

	  context "when not signed in" do

	    before do
	      session[:user_id] = nil
	    end

	    it "cannot access index" do
	      get :index

	      expect(response).to redirect_to(new_session_url)
	    end

	    it "cannot access show" do
	      get :show, id: @user

	      expect(response).to redirect_to(new_session_url)
	    end

	    it "cannot access edit" do
	      get :edit, id: @user

	      expect(response).to redirect_to(new_session_url)
	    end

	    it "cannot access update" do
	      patch :update, id: @user

	      expect(response).to redirect_to(new_session_url)
	    end

	    it "cannot access destroy" do
	      delete :destroy, id: @user

	      expect(response).to redirect_to(new_session_url)
	    end
	  end
	end

	describe UsersController do

	  before do
	    @user = User.create!(user_attributes)
	  end

	  context "when not signed in" do
	    ...
	  end

	  context "when signed in as the wrong user" do

	    before do
	      @wrong_user = User.create!(user_attributes(email: "wrong@example.com"))
	      session[:user_id] = @wrong_user
	    end

	    it "cannot edit another user" do
	      get :edit, id: @user

	      expect(response).to redirect_to(root_url)
	    end

	    it "cannot update another user" do
	      patch :update, id: @user

	      expect(response).to redirect_to(root_url)
	    end

	    it "cannot destroy another user" do
	      delete :destroy, id: @user

	      expect(response).to redirect_to(root_url)
	    end

	  end

	end
	 
end

