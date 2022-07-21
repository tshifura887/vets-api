class CreatePets < ActiveRecord::Migration[6.1]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :pet_type
      t.string :string
      t.string :pet_breed

      t.timestamps
    end
  end
end
