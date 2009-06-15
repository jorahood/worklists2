class IndexKbresourceOnId < ActiveRecord::Migration
  def self.up
    add_index :kbresource, :id
  end

  def self.down
    remove_index :kbresource, :id
  end
end
