FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email  }
    password_digest { "Password123 "}
    password_confirmation { "Password123 "}
  end
end
