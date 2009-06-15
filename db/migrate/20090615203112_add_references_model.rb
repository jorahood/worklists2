class AddReferencesModel < ActiveRecord::Migration
  def self.up
    create_table :references, :id => false do |t|
      t.string :fromid
      t.string :toid
    end
  end

  def self.down
    remove_table :references
  end
end
