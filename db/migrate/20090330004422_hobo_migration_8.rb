class HoboMigration8 < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.text     :text
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :listed_doc_id
      t.integer  :owner_id
    end
  end

  def self.down
    drop_table :notes
  end
end
