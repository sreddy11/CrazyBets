# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invitation do
    sender_id 1
    recipient_email "admin@yahoo.com"
    invite_token "token"
  end
end
