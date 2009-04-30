class AddDocs < ActiveRecord::Migration
  def self.up
    create_table :docs do |t|
      t.string   :docid
      t.string   :title
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :docs
  end
end
