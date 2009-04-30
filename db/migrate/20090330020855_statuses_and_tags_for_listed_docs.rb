class StatusesAndTagsForListedDocs < ActiveRecord::Migration
  def self.up
    add_column :listed_docs, :status, :string
    add_column :listed_docs, :tag, :string
  end

  def self.down
    remove_column :listed_docs, :status
    remove_column :listed_docs, :tag
  end
end
