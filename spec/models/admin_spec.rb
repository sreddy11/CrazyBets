require 'spec_helper'

describe Admin do
  
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:user_name) }

  it { should ensure_length_of(:password).is_at_least(6) }

  it { should_not allow_value("not_an_email").for(:email) }
  it { should allow_value("123@yahoo.com").for(:email) }

  it { should have_many(:invitations).class_name('Invitation')}
  it { should belong_to(:invitation) }
end
