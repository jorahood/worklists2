class CreateTaggings < ActiveRecord::Migration
  def self.up
    create_table :taggings do |t|
      t.integer :listed_doc_id
      t.integer :tag_id
      t.timestamps
    end

    rename_column :tags, :listed_doc_id, :tagging_id
  end

  def self.down
    drop_table :taggings
    rename_column :tags, :tagging_id, :listed_doc_id
  end
end
