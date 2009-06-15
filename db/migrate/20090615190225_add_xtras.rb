class AddXtras < ActiveRecord::Migration
  def self.up
    create_table :xtra, :id => false do |t|
      t.string :term
      t.integer :weight
      t.string :id
    end
  end

  def self.down
    drop_table :xtra
  end
end
