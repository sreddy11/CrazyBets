require 'spec_helper'

describe User do
  
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:user_name) }

  it { should have_and_belong_to_many(:bets) }

  it { should ensure_length_of(:password).is_at_least(6) }

  it { should_not allow_value("not_an_email").for(:email) }
  it { should allow_value("123@yahoo.com").for(:email) }

end
