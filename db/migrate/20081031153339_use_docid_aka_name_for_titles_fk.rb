class UseDocidAkaNameForTitlesFk < ActiveRecord::Migration
  def self.up
    rename_column :titles, :doc_id, :doc_name
  end

  def self.down
    rename_column :titles, :doc_name, :doc_id
  end
end
