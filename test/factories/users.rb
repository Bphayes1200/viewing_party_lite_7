FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email  }
    password { "Password123"}
    password_confirmation { "Password123"}
    role { 1 } 
  end
end
