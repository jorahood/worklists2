class AddIndexToDocumentdomain < ActiveRecord::Migration
  def self.up
    add_index :documentdomain, :id
  end

  def self.down
    drop_index :documentdomain, :id
  end
end
