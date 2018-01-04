class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, length: 50, null: false
      t.string :email, length: 50, null: false
      t.string :encrypted_password, length: 20, null: false
      t.string :salt, length: 150, null: false

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :salt, unique: true
  end
end
