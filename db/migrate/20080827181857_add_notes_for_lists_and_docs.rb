class AddNotesForListsAndDocs < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.text     :text
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :list_id
      t.integer  :doc_id
    end
  end

  def self.down
    drop_table :notes
  end
end
