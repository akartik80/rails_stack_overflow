class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.belongs_to :question, index: true, null: false, foreign_key: true
      t.belongs_to :user, index: true, null: false, foreign_key: true
      t.text :text, null: false
      t.boolean :accepted, default: false
      t.timestamp :deleted_at, index: true

      t.timestamps
    end
  end
end
