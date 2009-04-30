class HoboMigration3 < ActiveRecord::Migration
  def self.up
    create_table :docs_in_list, :force => true do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :doc_id
      t.integer  :list_id
    end

    rename_column :notes, :listed_doc_id, :docs_in_list_id
  end

  def self.down
    rename_column :notes, :docs_in_list_id, :listed_doc_id
    drop_table :docs_in_list
  end
end
