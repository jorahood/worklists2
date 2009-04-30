class AddingLocalDocs < ActiveRecord::Migration
  def self.up
    create_table :local_docs do |t|
      t.string   :docid
      t.datetime :created_at
      t.datetime :updated_at
    end
    
    rename_column :list_items, :doc_id, :local_doc_id
  end

  def self.down
    rename_column :list_items, :local_doc_id, :doc_id
    
    drop_table :local_docs
  end
end
