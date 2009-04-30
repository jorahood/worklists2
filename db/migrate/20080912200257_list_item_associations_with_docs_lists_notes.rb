class ListItemAssociationsWithDocsListsNotes < ActiveRecord::Migration
  def self.up
    add_column :list_items, :doc_id, :integer
    add_column :list_items, :list_id, :integer
    
    rename_column :notes, :doc_id, :list_item_id
  end

  def self.down
    remove_column :list_items, :doc_id
    remove_column :list_items, :list_id
    
    rename_column :notes, :list_item_id, :doc_id
  end
end
