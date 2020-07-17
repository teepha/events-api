FactoryBot.define do
  factory :event, aliases: [:event_two] do
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence(20) }
    venue { Faker::Lorem.sentence(15) }
    start_time { Faker::Time.forward(days: 5) }
    end_time { Faker::Time.forward(days: 5) }
    is_free { false }
    gate_fee { Faker::Number.number(digits: 4) }
    is_active { true }

    factory :free do
      is_free { true }
    end
  end
end