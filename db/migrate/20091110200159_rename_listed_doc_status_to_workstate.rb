class RenameListedDocStatusToWorkstate < ActiveRecord::Migration
  def self.up
    rename_column :listed_docs, :status, :workstate
  end

  def self.down
    rename_column :listed_docs, :workstate, :status
  end
end
