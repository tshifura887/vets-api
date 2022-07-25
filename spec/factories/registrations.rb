FactoryBot.define do
    factory :registration do
        requested_registration { Faker::Boolean.boolean }
        accepted { Faker::Boolean.boolean(false)}
        registration_date { Time.now}
        pet_id nil
    end
end