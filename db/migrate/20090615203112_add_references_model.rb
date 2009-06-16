class AddReferencesModel < ActiveRecord::Migration
  def self.up
    create_table :references, :primary_key => [:fromid, :toid] do |t|
      t.string :fromid
      t.string :toid
    end
  end

  def self.down
    drop_table :references
  end
end
