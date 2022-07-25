FactoryBot.define do
    factory :pet do
        name { Faker::Name.name}
        pet_type { Faker::Creature::Animal.name}
        pet_breed { 'Beabull'}
        age { '2'}
    end
end