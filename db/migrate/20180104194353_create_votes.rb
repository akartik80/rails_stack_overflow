class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.references :votable, polymorphic: true, index: true, null: false
      t.belongs_to :user, index: true, null: false, foreign_key: true
      t.integer :vote_type, index: true, null: false
      t.timestamps
    end
  end
end
