class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, length: 50, null: false
      t.string :email, length: 50, null: false, unique: true
      t.string :password, length: 100, null: false
      t.string :salt, length: 150, null: false, unique: true
      t.boolean :deleted_at

      t.timestamps
    end
  end
end
