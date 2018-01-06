class QuestionsTags < ActiveRecord::Migration[5.1]
  def change
    create_join_table :questions, :tags do |t|
      t.belongs_to :question, foreign_key: true, index: true, null: false
      t.belongs_to :tag, foreign_key: true, index: true, null: false
      t.timestamp :deleted_at, index: true
      t.timestamps
    end
  end
end
