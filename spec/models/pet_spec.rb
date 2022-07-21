require 'rails_helper'

RSpec.describe Pet, type: :model do
  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:pet_type)}
  it { should validate_presence_of(:pet_breed)}
end
