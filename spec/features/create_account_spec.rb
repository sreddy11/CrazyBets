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
      fill_in "Password", :with => "password"
      fill_in "Confirm Password", :with => "password"
      fill_in "E-mail", :with => "email@yahoo.com"
      click_button "Sign Up"
    end

    it "creates the account" do
      current_path.should == '/users/sid'
      page.should have_content("Your Account (sreddy1) has been successfully created")
    end
  
    context "invalid form" do

      before do 
        visit '/users/new'
        fill_in "First Name", :with => ''
        fill_in "Last Name", :with => ''
        fill_in "User Name", :with => 'sreddy1'
        fill_in "Password", :with => "pass"
        fill_in "Confirm Password", :with => "pass2"
        fill_in "E-mail", :with => "email"
        click_button "Create User"
      end

      it "gives new errors" do
        current_path.should == '/users'
        page.should have_content("First Name can't be blank")
        page.should have_content("Last Name can't be blank")
        page.should have_content("User name has already been taken")
        page.should have_content("Password is too short (minimum is 6 characters")
        page.should have_content("Password doesn't match confirmation")
        page.should have_content("Not a valid e-mail format")
      end
    end
  end
end
