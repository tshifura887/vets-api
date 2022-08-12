require 'rails_helper'

RSpec.describe Pet, type: :model do
  it { should have_many(:registrations).dependent(:destroy)}
  it { should have_many(:users).through(:registrations)}
  it { should have_many(:appointments).dependent(:destroy)}
  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:pet_type)}
  it { should validate_presence_of(:pet_breed)}
end
