class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true, index: true, null: false
      t.belongs_to :user, index: true, null: false
      t.text :text

      t.timestamps
    end
  end
end
