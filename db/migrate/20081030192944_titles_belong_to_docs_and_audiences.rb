class TitlesBelongToDocsAndAudiences < ActiveRecord::Migration
  def self.up
    add_column :titles, :doc_id, :integer
    add_column :titles, :audience_id, :integer
  end

  def self.down
    remove_column :titles, :doc_id
    remove_column :titles, :audience_id
  end
end
