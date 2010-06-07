class AddTextSearchToSearch < ActiveRecord::Migration
  def self.up
    add_column :searches, :text_search, :string
  end

  def self.down
    remove_column :searches, :text_search
  end
end
