class AddingTitleAndAudience < ActiveRecord::Migration
  def self.up
    create_table :audiences do |t|
      t.string :audience
      t.string :description
    end
    
    create_table :titles do |t|
      t.string :title
    end
  end

  def self.down
    drop_table :audiences
    drop_table :titles
  end
end
