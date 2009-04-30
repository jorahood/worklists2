class MakeDocsNameFieldThePrimaryKey < ActiveRecord::Migration
  def self.up
    drop_table :docs

    # there is no way I know of yet to make a non-numeric primary key with
    # migrations, so I had to do it directly on the docs table with mysql-admin.
    # Hoping that composite-primary-keys will take care of that.
    create_table :docs, :force => true, :id => false do |t|
      t.string   "name", :limit => 4
      t.date     "birthdate"
      t.datetime "modifieddate"
      t.date     "approveddate"
      t.string   "owner"
      t.string   "author"
      t.string   "importance"
      t.string   "visibility"
      t.string   "volatility"
      t.string   "status"
    end
  end

  def self.down
    drop_table :docs

    create_table "docs", :force => true do |t|
      t.string   "name"
      t.date     "birthdate"
      t.datetime "modifieddate"
      t.date     "approveddate"
      t.string   "owner"
      t.string   "author"
      t.string   "importance"
      t.string   "visibility"
      t.string   "volatility"
      t.string   "status"
    end

  end
end