require 'rails_helper'

RSpec.describe User, type: :model do
  # it { should have_many(:pets) }
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:role)}
end
