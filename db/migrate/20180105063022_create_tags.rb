class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.belongs_to :taggable, polymorphic: true
      t.string :text, null: false
      t.text :description

      t.timestamps
    end
  end
end
