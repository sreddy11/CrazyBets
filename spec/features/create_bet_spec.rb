require 'spec_helper'

describe "inviting and creating admin account" do

  let!(:admin) { FactoryGirl.create(:admin) }

  before do
    login_admin
  end

  it "should go to show page" do
    current_path.should == '/admins/sreddy1'
  end

  context "creating bet" do

    before do
      fill_in 'Metric 1', :with => 'Test 1'
      fill_in 'Metric 2', :with => 'Test 2'
      click_button 'Create Bet'
    end

    it "should create the bet" do
      current_path.should == '/admins/sreddy1'
      page.should have_content("Bet Created")
      Bet.last.metric1.topic.should == 'Test 1'
    end
  end

  context "creating bet" do

    before do
      fill_in 'Metric 1', :with => ''
      fill_in 'Metric 2', :with => 'Test 2'
      click_button 'Create Bet'
    end

    it "should create the bet" do
      current_path.should == '/admin/bets'
      page.should have_content("can't be blank")
      Bet.all.count.should == 0
    end
  end
end
