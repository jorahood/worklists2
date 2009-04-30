class NoMoreLocalDocsWillBeCachingDocData < ActiveRecord::Migration
  def self.up
    drop_table :local_docs
    
    create_table :docs do |t|
      t.string   :docid
      t.datetime :birthdate
      t.datetime :modifieddate
      t.datetime :approveddate
      t.string   :owner
      t.string   :author
      t.string   :importance
      t.string   :visibility
      t.string   :volatility
      t.string   :status
    end
  end

  def self.down
    create_table "local_docs", :force => true do |t|
      t.string   "doc_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    drop_table :docs
  end
end
