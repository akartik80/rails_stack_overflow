class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions do |t|
      t.belongs_to :user, index: true, null: false, foreign_key: true
      t.string :token, null: false
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
