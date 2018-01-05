class CreateTagAssociations < ActiveRecord::Migration[5.1]
  def change
    create_table :tag_associations, id: false do |t|
      t.belongs_to :tag
      t.belongs_to :taggable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
