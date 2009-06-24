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

ActiveRecord::Schema.define(:version => 20090624172948) do

  create_table "boilerusage", :id => false, :force => true do |t|
    t.string "boiler"
    t.string "fromid"
  end

  add_index "boilerusage", ["boiler"], :name => "index_boilerusage_on_boiler"
  add_index "boilerusage", ["fromid"], :name => "index_boilerusage_on_fromid"

  create_table "document", :id => false, :force => true do |t|
    t.string  "id"
    t.date    "birthdate"
    t.date    "modifieddate"
    t.date    "approveddate"
    t.string  "owner"
    t.string  "author"
    t.integer "importance"
    t.integer "visibility"
    t.integer "volatility"
    t.integer "status"
  end

  add_index "document", ["id"], :name => "index_docs_on_id", :unique => true

  create_table "documentdomain", :id => false, :force => true do |t|
    t.string "id"
    t.string "domain"
  end

  add_index "documentdomain", ["id"], :name => "index_documentdomain_on_id"

  create_table "documentnames", :id => false, :force => true do |t|
    t.string "name"
    t.string "docid"
  end

  add_index "documentnames", ["docid"], :name => "index_documentnames_on_docid"
  add_index "documentnames", ["name"], :name => "index_documentnames_on_name"

  create_table "domain_searches", :force => true do |t|
    t.integer "search_id"
    t.string  "domain_id"
  end

  create_table "domainlist", :id => false, :force => true do |t|
    t.string "domain"
    t.string "class"
    t.string "type"
    t.string "description"
    t.string "visible",     :limit => 512
    t.string "accessible",  :limit => 512
    t.string "audience",    :limit => 512
  end

  create_table "expire", :id => false, :force => true do |t|
    t.string "id"
    t.date   "expiredate"
    t.string "explanation"
  end

  create_table "hotitem", :id => false, :force => true do |t|
    t.string "id"
    t.string "hotitem"
  end

  add_index "hotitem", ["id"], :name => "index_hotitem_on_id"

  create_table "importance", :id => false, :force => true do |t|
    t.integer "rank"
    t.string  "importance"
  end

  create_table "kba_by_searches", :force => true do |t|
    t.integer "search_id"
    t.string  "kba_by_id"
  end

  create_table "kba_searches", :force => true do |t|
    t.integer "search_id"
    t.string  "kba_id"
  end

  create_table "kba_usage", :id => false, :force => true do |t|
    t.string "docid", :limit => 4, :default => "", :null => false
    t.string "kba",   :limit => 4, :default => "", :null => false
  end

  create_table "kbresource", :id => false, :force => true do |t|
    t.string "id"
    t.string "username"
  end

  add_index "kbresource", ["id"], :name => "index_kbresource_on_id"

  create_table "kbuser", :id => false, :force => true do |t|
    t.string "username"
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

  create_table "references", :id => false, :force => true do |t|
    t.string "fromid", :default => "", :null => false
    t.string "toid",   :default => "", :null => false
  end

  create_table "searches", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "importance_id"
    t.integer  "visibility_id"
    t.integer  "volatility_id"
    t.integer  "status_id"
    t.string   "author_id"
    t.string   "owner_id"
    t.date     "expiredate"
    t.string   "resource_id"
    t.string   "title_search"
    t.date     "birthdate"
    t.date     "modifieddate"
    t.date     "approveddate"
    t.string   "boiler_id"
    t.string   "hotitem_id"
    t.string   "xtra_search"
    t.string   "approveddate_is"
    t.string   "birthdate_is"
    t.string   "modifieddate_is"
    t.string   "expiredate_is"
    t.string   "importance_is"
    t.string   "visibility_is"
    t.string   "volatility_is"
    t.string   "status_is"
  end

  create_table "status", :id => false, :force => true do |t|
    t.integer "rank"
    t.string  "status"
  end

  create_table "titleaudience", :id => false, :force => true do |t|
    t.string "audience"
    t.string "description"
  end

  create_table "titlecache", :id => false, :force => true do |t|
    t.string  "title"
    t.string  "docid",    :default => "", :null => false
    t.string  "audience", :default => "", :null => false
    t.integer "id"
  end

  add_index "titlecache", ["audience"], :name => "index_titlecache_on_audience"
  add_index "titlecache", ["docid"], :name => "index_titlecache_on_docid"

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

  create_table "visibility", :id => false, :force => true do |t|
    t.integer "rank"
    t.string  "visibility"
  end

  create_table "volatility", :id => false, :force => true do |t|
    t.integer "rank"
    t.string  "volatility"
  end

  create_table "xtra", :id => false, :force => true do |t|
    t.string  "term"
    t.integer "weight"
    t.string  "id"
  end

  add_index "xtra", ["id"], :name => "index_xtra_on_id"

end
