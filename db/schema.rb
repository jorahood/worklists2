# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090507182653) do

  create_table "audiences", :id => false, :force => true do |t|
    t.string "id"
    t.string "description"
  end

  create_table "boilers", :id => false, :force => true do |t|
    t.string "name"
    t.string "doc_id"
  end

  create_table "docs", :id => false, :force => true do |t|
    t.string   "id"
    t.date     "birthdate"
    t.datetime "modifieddate"
    t.date     "approveddate"
    t.string   "owner_id"
    t.string   "author_id"
    t.integer  "importance_id"
    t.integer  "visibility_id"
    t.integer  "volatility_id"
    t.integer  "status_id"
  end

  add_index "docs", ["id"], :name => "index_docs_on_id", :unique => true

  create_table "domained_docs", :id => false, :force => true do |t|
    t.string "doc_id"
    t.string "domain_id"
  end

  create_table "domains", :id => false, :force => true do |t|
    t.string "id"
    t.string "domain_class"
    t.string "domain_type"
    t.string "description"
    t.string "visible",      :limit => 512
    t.string "accessible",   :limit => 512
    t.string "audience",     :limit => 512
  end

  create_table "expirations", :id => false, :force => true do |t|
    t.string "doc_id"
    t.date   "date"
    t.string "reason"
  end

  create_table "hotitems", :id => false, :force => true do |t|
    t.string "doc_id"
    t.string "name"
  end

  create_table "importances", :id => false, :force => true do |t|
    t.integer "id"
    t.string  "name"
  end

  create_table "kbresources", :id => false, :force => true do |t|
    t.string "doc_id"
    t.string "kbuser_id"
  end

  create_table "kbusers", :id => false, :force => true do |t|
    t.string "id"
    t.string "lastname"
    t.string "firstname"
    t.string "email"
    t.string "worknumber"
    t.string "homenumber"
    t.string "status"
    t.string "password"
    t.string "pagernumber"
  end

  create_table "listed_docs", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "list_id"
    t.string   "doc_id"
    t.string   "status"
    t.string   "tag"
  end

  create_table "lists", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "owner_id"
    t.text     "comment"
    t.string   "audience_id"
  end

  create_table "notes", :force => true do |t|
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
    t.integer  "listed_doc_id"
  end

  create_table "statuses", :id => false, :force => true do |t|
    t.integer "id"
    t.string  "name"
  end

  create_table "titles", :id => false, :force => true do |t|
    t.string "title"
    t.string "doc_id"
    t.string "audience_id"
  end

  create_table "used_boilers", :id => false, :force => true do |t|
    t.string "boiler_name"
    t.string "doc_id"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "email_address"
    t.boolean  "administrator",                           :default => false
    t.string   "state",                                   :default => "active"
    t.datetime "key_timestamp"
  end

  create_table "visibilities", :id => false, :force => true do |t|
    t.integer "id"
    t.string  "name"
  end

  create_table "volatilities", :id => false, :force => true do |t|
    t.integer "id"
    t.string  "name"
  end

end
