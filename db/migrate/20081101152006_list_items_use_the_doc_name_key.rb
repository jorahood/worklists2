class ListItemsUseTheDocNameKey < ActiveRecord::Migration
  def self.up
    add_column :list_items, :doc_name, :string, :limit=> 4
    remove_column :list_items, :doc_id
  end

  def self.down
    add_column :list_items, :doc_id, :integer, :limit => 4
    remove_column :list_items, :doc_name
  end
end
