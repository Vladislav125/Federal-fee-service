class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :user_name, null: false
      t.string :login, null: false
      t.string :password_digest, null: false
      t.string :position, null: false
      t.integer :inn
      t.integer :income, default: 0
      t.integer :tax, default: 0
      t.integer :tax_payed, default: 0

      t.timestamps
    end
    add_index :users, :login, unique: true
  end
end
