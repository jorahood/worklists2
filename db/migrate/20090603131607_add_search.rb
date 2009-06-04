class AddSearch < ActiveRecord::Migration
  def self.up
    create_table :searches do |t|
      t.string  :name
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :importance_id
      t.integer  :visibility_id
      t.integer :volatility_id
      t.integer :status_id
      t.string :author_id
      t.string :owner_id
    end  end

  def self.down
    drop_table :searches
  end
end
