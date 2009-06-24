class DropAndRecreateTitlecacheWithPks < ActiveRecord::Migration
  def self.up
    create_table "titlecache", :primary_key => [:docid, :audience], :force => true do |t|
      t.string  "title"
      t.string  "docid"
      t.string  "audience"
    end

    add_index "titlecache", ["audience"], :name => "index_titlecache_on_audience"
    add_index "titlecache", ["docid"], :name => "index_titlecache_on_docid"
  end

  def self.down
  create_table "titlecache", :id => false, :force => true do |t|
    t.string  "title"
    t.string  "docid"
    t.string  "audience"
  end

  add_index "titlecache", ["audience"], :name => "index_titlecache_on_audience"
  add_index "titlecache", ["docid"], :name => "index_titlecache_on_docid"
  end

end
