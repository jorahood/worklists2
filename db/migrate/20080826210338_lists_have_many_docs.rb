class ListsHaveManyDocs < ActiveRecord::Migration
  def self.up
    add_column :docs, :list_id, :integer
  end

  def self.down
    remove_column :docs, :list_id
  end
end
