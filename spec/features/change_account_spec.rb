require 'spec_helper'

describe "Using an account" do

  before do
    create_user
  end

  context "Logout" do
  
    before do
      click_link 'Welcome, sid!'
      click_link 'Logout'
    end

    it "goes to the login page" do
      page.should have_content("Logout Successful")
    end

    context "Valid Login" do
      before do
        click_link "Login/Register"
        fill_in 'sign_in_name', :with => 'sreddy1'
        fill_in 'sign_in_password', :with => 'password'
        click_button 'login-button'
      end

      it "logs in" do
        page.should have_content("Login Successful")
      end

      context "edit profile" do
        before do
          visit '/'
          click_link "Welcome, sid!"
          click_link "Edit Profile"
          fill_in 'First Name', :with => 'Sid'
          click_button "Save Changes"
        end

        it "should update the profile" do
          page.should have_content("Welcome, Sid!")
        end
      end

      context "delete profile" do
        before do
          visit '/'
          click_link "Delete Profile"
        end
        
        it "deletes the profile" do
          page.should have_content("Your account has been deleted")
        end

        context "logging on should no longer work" do

          before do
            click_link "Login/Register"
            fill_in 'sign_in_name', :with => 'sreddy1'
            fill_in 'sign_in_password', :with => 'password'
            click_button 'login-button'
          end

          it "will be invalid" do
            current_path.should == '/login'
            page.should have_content("Login Invalid")
          end
        end
      end
    end
    
    context "invalid login" do
      before do
        visit '/'
        click_link "Login/Register"
        fill_in 'login_user_name', :with => 'sreddy1'
        fill_in 'login_password', :with => 'password2'
        click_button 'login-button'
      end

      it "does not logs in" do
        current_path.should == '/login'
        page.should have_content("Login Invalid")
      end
    end
  end
end

