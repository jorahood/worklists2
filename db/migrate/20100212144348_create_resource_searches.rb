class CreateResourceSearches < ActiveRecord::Migration
  def self.up
    create_table :resource_searches, :id => false do |t|
      t.string :resource_id
      t.integer :search_id
  end

  def self.down
    drop_table :resource_searches
  end
  end
end
