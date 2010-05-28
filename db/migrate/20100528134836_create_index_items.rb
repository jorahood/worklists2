class CreateIndexItems < ActiveRecord::Migration
  def self.up
    create_table :indexitem, :id => false do |t|
      t.string :docid
      t.string :word
      t.decimal :score, 
        :precision => 7,
        :scale => 4
    end
  end

  def self.down
    drop_table :indexitem
  end
end
