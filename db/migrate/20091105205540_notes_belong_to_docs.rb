class NotesBelongToDocs < ActiveRecord::Migration
  def self.up
    add_column :notes, :doc_id, :string
  end

  def self.down
    remove_column :notes, :doc_id, :string
  end
end
