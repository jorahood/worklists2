class DocidShouldBeDocId < ActiveRecord::Migration
  def self.up
    rename_column :local_docs, :docid, :doc_id
  end

  def self.down
    rename_column :local_docs, :doc_id, :docid
  end
end
