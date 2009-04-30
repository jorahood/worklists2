class RenameDocidToName < ActiveRecord::Migration
  def self.up
    rename_column :docs, :docid, :name
  end

  def self.down
    rename_column :docs, :name, :docid
  end
end
