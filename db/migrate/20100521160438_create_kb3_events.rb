class CreateKb3Events < ActiveRecord::Migration
  def self.up
    create_table :event, :id => false do |t|
    t.string :action
    t.string :editor
    t.string :id
    t.string :fielda
    t.string :fieldb
    t.datetime :timestamp
    t.string :type
    t.string :version
  end
  end

  def self.down
    drop_table :event
  end
end
