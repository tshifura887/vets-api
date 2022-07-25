class AddUserToRegistration < ActiveRecord::Migration[6.1]
  def change
    add_reference :registrations, :user, null: false, foreign_key: true
  end
end
