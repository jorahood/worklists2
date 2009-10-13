class CreateSearchToListAssignments < ActiveRecord::Migration
  def self.up
    create_table :search_to_list_assignments do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :search_to_list_assignments
  end
end
