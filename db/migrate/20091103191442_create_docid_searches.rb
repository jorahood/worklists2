class CreateDocidSearches < ActiveRecord::Migration
  def self.up
    create_table :docid_searches, :id => false do |t|
      t.string :doc_id
      t.integer :search_id
    end
  end

  def self.down
    drop_table :docid_searches
  end
end
