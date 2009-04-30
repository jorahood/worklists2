class UsingSameColumnNamesAsOnBellForFks < ActiveRecord::Migration
  def self.up
    rename_column :titles, :doc_id, :docid
  end

  def self.down
    rename_column :titles, :docid, :doc_id
  end
end
