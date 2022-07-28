FactoryBot.define do
    factory :appointment do
        appointment_date { Faker::Time.forward(days: 23)}
    end
end