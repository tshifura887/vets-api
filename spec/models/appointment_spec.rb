require 'rails_helper'

RSpec.describe Appointment, type: :model do
    it { should belong_to(:registration)}
    it { should validate_presence_of(:appointment_date)}
end
