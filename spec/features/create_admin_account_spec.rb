require 'spec_helper'

describe "inviting and creating admin account" do

  let!(:admin) { FactoryGirl.create(:admin) }

  before do
    visit '/'
    click_link 'Login/Register'
    fill_in 'sign_in_name', :with => 'sreddy1'
    fill_in 'sign_in_password', :with => 'password'
    click_button 'login-button'
  end

  it "logs in" do
    current_path.should == '/admins/sreddy1'
    page.should have_content("Login Successful")
  end

  context "invite another admin" do

    before do 
      click_link "Welcome, Sid!"
      click_link "Invite New Admin"
    end

    it "goes to admin invite page" do
      current_path.should == '/admins/invitation/new'
    end

    context "invite user" do
      before do
        fill_in 'E-mail of Invitee', :with => 'admin@yahoo.com'
        click_button 'Invite this Person'
      end

      it "invites the user" do
        page.should have_content("Invitation has been sent")
      end

      context "accept invitation" do
        let!(:invitation) { FactoryGirl.create(:invitation) }
        before do
          click_link "Welcome, Sid!"
          click_link 'Logout'
          visit "/admins/new?invite_token=#{invitation.invite_token}"
          fill_in "First Name", :with => 'sid'
          fill_in "Last Name", :with => 'reddy'
          fill_in "User Name", :with => 'sreddy2'
          fill_in "admin[password]", :with => "password"
          fill_in "Confirm Password", :with => "password"
          fill_in "E-mail", :with => "email@yahoo.com"
          click_button "Sign Up"
        end
        
        it "should accept the token" do
          current_path.should == "/admins/sreddy2"
          page.should have_content("Admin account successfully created")
        end
      end
    end
  end
end
