require 'spec_helper'

describe "Using an account" do

  let!(:admin) { FactoryGirl.create(:admin) }
  
  context "Login" do
      before do
        visit '/'
        click_link "Login/Register"
        fill_in 'sign_in_name', :with => admin.user_name
        fill_in 'sign_in_password', :with => admin.password
        click_button 'login-button'
      end

      it "logs in" do
        page.should have_content("Login Successful")
      end

      context "edit profile" do
        before do
          visit '/'
          click_link "Welcome, Sid!"
          click_link "Edit Profile"
          fill_in 'First Name', :with => 'sid'
          click_button "Save Changes"
        end

        it "should update the profile" do
          page.should have_content("Welcome, sid!")
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
            fill_in 'sign_in_name', :with => admin.user_name
            fill_in 'sign_in_password', :with => admin.password
            click_button 'login-button'
          end

          it "will be invalid" do
            current_path.should == '/login'
            page.should have_content("Login Invalid")
          end
        end
      end
    end
  end

