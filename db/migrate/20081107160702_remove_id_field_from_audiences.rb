class RemoveIdFieldFromAudiences < ActiveRecord::Migration
  def self.up
    drop_table :audiences

#     again, making name the primary key using MySQL Admin, hopefully using
#     Composite Primary Keys in future to do so through Rails
    create_table :audiences, :force => true, :id => false do |t|
      t.string   "name"
      t.string   "description"
    end
  end

  def self.down
    drop_table :audiences

    create_table :audiences, :force => true do |t|
      t.string   "name"
      t.string   "description"
    end
  end
end
