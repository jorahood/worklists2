class AddKbresourceToSearch < ActiveRecord::Migration
  def self.up
    add_column :searches, :resource_id, :string
  end

  def self.down
    remove_column :searches, :resource_id
  end
end
