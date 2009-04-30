class CreateListItemsToJoinDocsAndLists < ActiveRecord::Migration
  def self.up
    create_table :list_items do |t|
      t.datetime :created_at
      t.datetime :updated_at
    end
    
    remove_column :docs, :list_id
  end

  def self.down
    add_column :docs, :list_id, :integer
    
    drop_table :list_items
  end
end
