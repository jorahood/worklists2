class Hoboify < ActiveRecord::Migration
  def self.up
    drop_table :docs
    drop_table :notes
    drop_table :log_events
    drop_table :tags
    
    add_column :users, :crypted_password, :string, :limit => 40
    add_column :users, :salt, :string, :limit => 40
    add_column :users, :remember_token, :string
    add_column :users, :remember_token_expires_at, :datetime
    add_column :users, :email_address, :string
    add_column :users, :administrator, :boolean, :default => false
    add_column :users, :state, :string, :default => "active"
    add_column :users, :key_timestamp, :datetime
    remove_column :users, :role
    remove_column :users, :first_name
    remove_column :users, :last_name
    
    add_column :lists, :name, :string
    remove_column :lists, :title
    remove_column :lists, :user_id
  end

  def self.down
    remove_column :users, :crypted_password
    remove_column :users, :salt
    remove_column :users, :remember_token
    remove_column :users, :remember_token_expires_at
    remove_column :users, :email_address
    remove_column :users, :administrator
    remove_column :users, :state
    remove_column :users, :key_timestamp
    add_column :users, :role, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    
    remove_column :lists, :name
    add_column :lists, :title, :string
    add_column :lists, :user_id, :integer
    
    create_table "docs", :force => true do |t|
      t.text     "docid"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "list_id"
    end
    
    create_table "notes", :force => true do |t|
      t.text     "text"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "list_id"
      t.integer  "user_id"
    end
    
    create_table "log_events", :force => true do |t|
      t.string   "type"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "user_id"
    end
    
    create_table "tags", :force => true do |t|
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
