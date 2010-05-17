class CreateWorkshopWfinodes < ActiveRecord::Migration
  def self.up
    create_table :wfinode do |t|
    t.integer :desk
    t.integer :parent
    t.string :creator
    t.string :owner
    t.string :usergroup
    t.date :birthdate
    t.date :lastmodified
    t.integer :permissions
    end
  end

  def self.down
    drop_table :wfinode
  end
end
