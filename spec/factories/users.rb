FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password "password"
    login_type "Manual"
    img_url "img_url"
    social_id "social_id"
  end
end