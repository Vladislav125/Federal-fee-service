class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :license_plate, null: false
      t.string :model, null: false
      t.integer :power, null: false
      t.integer :vehicle_tax
      t.belongs_to :user

      t.timestamps
    end
    add_index :vehicles, :license_plate, unique: true
  end
end
