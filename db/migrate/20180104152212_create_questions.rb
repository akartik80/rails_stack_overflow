class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.belongs_to :user, index: true, null: false
      t.text :text, null: false
      t.integer :duplicate_question_id
      t.boolean :wiki, default: false
      t.timestamp :deleted_at
      t.timestamps
    end
  end
end
