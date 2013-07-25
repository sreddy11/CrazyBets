require 'spec_helper'

describe Bet do

  it { should belong_to(:metric1) }
  it { should belong_to(:metric2) }
  
  it { should have_and_belong_to_many(:users) }
  
  it { should accept_nested_attributes_for(:metric1) }
  it { should accept_nested_attributes_for(:metric2) }

  it { should validate_presence_of(:metric1) }

end
