require 'rails_helper'

RSpec.describe Appointment, type: :model do
    it { should belong_to(:pet)}
end
