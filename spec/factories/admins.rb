# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin do
    first_name 'Sid'
    last_name 'Reddy'
    user_name 'sreddy1'
    email 'sreddy1@swarthmore.edu'
    password 'password'
    password_confirmation 'password'
    invitation_id 1
  end
end
