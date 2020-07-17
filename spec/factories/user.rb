FactoryBot.define do
  factory :user, aliases: [:user_two] do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.cell_phone_in_e164 }
    password { Faker::Lorem.word }
    is_admin { false }

    factory :admin do
      is_admin { true }
    end
  end
end