class AddTitleAndDatesForSearches < ActiveRecord::Migration
  def self.up
    change_table(:searches) do |t|
      t.column :title_search, :string, :limit => 60
      t.column :birthdate_search, :date
      t.column :modifieddate_search, :datetime
      t.column :approveddate_search, :date
    end
  end

  def self.down
      change_table(:searches) do |t|
      t.remove :title_search
      t.remove :birthdate_search
      t.remove :modifieddate_search
      t.remove :approveddate_search
    end
  end
end
