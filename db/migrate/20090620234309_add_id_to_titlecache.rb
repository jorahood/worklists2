class AddIdToTitlecache < ActiveRecord::Migration

# Some kind of Rails association code, I think the :include, expects the
# :included model to have an "id" column
  def self.up
    add_column :titlecache, :id, :integer
  end

  def self.down
    remove_column :titlecache, :id
  end
end
