FactoryBot.define do
    factory :registration do
        registered { Faker::Boolean.boolean }
        accepted { Faker::Boolean.boolean(false)}
        registration_date { Time.now}
        pet_id nil
    end
end