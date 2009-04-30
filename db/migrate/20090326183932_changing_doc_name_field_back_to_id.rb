class ChangingDocNameFieldBackToId < ActiveRecord::Migration
  def self.up
    rename_column :docs, :name, :id
    
    rename_column :list_items, :doc_name, :doc_id
    
    rename_column :titles, :doc_name, :doc_id
  end

  def self.down
    rename_column :docs, :id, :name
    
    rename_column :list_items, :doc_id, :doc_name
    
    rename_column :titles, :doc_id, :doc_name
  end
end
