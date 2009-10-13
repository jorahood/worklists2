class AddAssociationsToSearchToListAssignment < ActiveRecord::Migration
  def self.up
    add_column :search_to_list_assignments, :list_id, :integer
    add_column :search_to_list_assignments, :search_id, :integer
  end

  def self.down
    remove_column :search_to_list_assignments, :list_id
    remove_column :search_to_list_assignments, :search_id
  end
end
