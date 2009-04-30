class HoboMigration1 < ActiveRecord::Migration
  def self.up
    drop_table :list_items
      end

  def self.down
    create_table "list_items", :force => true do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "list_id"
      t.string   "doc_id",     :limit => 4
    end
  end
end
