class LocalDocIdIsGone < ActiveRecord::Migration
  def self.up
    rename_column :list_items, :local_doc_id, :doc_id
  end

  def self.down
    rename_column :list_items, :doc_id, :local_doc_id
  end
end
