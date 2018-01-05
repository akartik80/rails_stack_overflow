class CreateRevisions < ActiveRecord::Migration[5.1]
  def change
    create_table :revisions do |t|
      t.references :revisionable, polymorphic: true, index: true, null: false
      t.jsonb :metadata

      t.timestamps
    end
  end
end
