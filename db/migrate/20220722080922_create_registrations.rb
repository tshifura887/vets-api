class CreateRegistrations < ActiveRecord::Migration[6.1]
  def change
    create_table :registrations do |t|
      t.boolean :requested_registration
      t.boolean :accepted, default: false
      t.datetime :registration_date
      t.references :pet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
