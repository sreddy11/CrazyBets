FactoryGirl.define do
  factory :user do

    first_name 'sid'
    last_name 'reddy'
    sequence(:user_name) {|n| "User#{n}"}
    password 'password'
    password_confirmation 'password'
    sequence(:email) {|n| "#{n}@yahoo.com"}
    admin false
    
  end
end
