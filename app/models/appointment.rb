class Appointment < ApplicationRecord
    belongs_to :registration

    validates_presence_of :appointment_date
end
