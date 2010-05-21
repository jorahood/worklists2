class IndexKb3EventOnUserIdAndDocumentId < ActiveRecord::Migration
  def self.up
    add_index Kb3Event.table_name.to_sym, :editor
    add_index Kb3Event.table_name.to_sym, :id
  end

  def self.down
    remove_index Kb3Event.table_name.to_sym, :editor
    remove_index Kb3Event.table_name.to_sym, :id
  end
end
