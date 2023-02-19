class CreateRealties < ActiveRecord::Migration[7.0]
  def change
    create_table :realties do |t|
      t.string :address, null: false
      t.integer :square, null: false
      t.integer :cost, null: false
      t.integer :realty_tax
      t.belongs_to :user

      t.timestamps
    end
    add_index :realties, :address, unique: true
  end
end
