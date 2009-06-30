class ListsBelongToSearches < ActiveRecord::Migration
  def self.up
    add_column :lists, :search_id, :integer
  end

  def self.down
    remove_column :lists, :search_id
  end
end
