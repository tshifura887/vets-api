require 'rails_helper'

RSpec.describe Registration, type: :model do
  it { should belong_to(:user)}
  it { should belong_to(:pet)}
  it { should validate_presence_of(:registration_date)}
end
