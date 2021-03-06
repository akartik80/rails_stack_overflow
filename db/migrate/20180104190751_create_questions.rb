class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.belongs_to :user, index: true, null: false, foreign_key: true
      t.text :text, null: false
      t.integer :duplicate_question_id
      t.boolean :wiki, default: false
      t.timestamp :deleted_at, index: true
      t.timestamps
    end
  end
end
