require "spec_helper"

module IntegrationMacros

  def create_user
    visit '/users/new'
    fill_in "First Name", :with => 'sid'
    fill_in "Last Name", :with => 'reddy'
    fill_in "User Name", :with => 'sreddy1'
    fill_in "user[password]", :with => "password"
    fill_in "Confirm Password", :with => "password"
    fill_in "E-mail", :with => "email@yahoo.com"
    click_button "Sign Up"
    end


end


