require 'spec_helper'

describe "Creating an account" do

  before do
    visit '/users/new'
  end

  context "valid form" do
    before do 
      fill_in "First Name", :with => 'sid'
      fill_in "Last Name", :with => 'reddy'
      fill_in "User Name", :with => 'sreddy1'
      fill_in "user[password]", :with => "password"
      fill_in "Confirm Password", :with => "password"
      fill_in "E-mail", :with => "email@yahoo.com"
      click_button "Sign Up"
    end

    it "creates the account" do
      current_path.should == '/users/sreddy1'
      page.should have_content("Your Account (sreddy1) has been successfully created")
    end
  end
  
  context "invalid form" do

    before do 
      visit '/users/new'
      fill_in "First Name", :with => ''
      fill_in "Last Name", :with => ''
      fill_in "User Name", :with => ''
      fill_in "user[password]", :with => "pass"
      fill_in "Confirm Password", :with => "pass2"
      fill_in "E-mail", :with => "email"
      click_button "Sign Up"
    end

    it "gives new errors" do
      current_path.should == '/users'
      page.should have_content("First name can't be blank")
      page.should have_content("Last name can't be blank")
      page.should have_content("User name can't be blank")
      page.should have_content("Password is too short (minimum is 6 characters")
      page.should have_content("Password confirmation doesn't match Password")
      page.should have_content("Email not a valid format")
    end
  end
end
