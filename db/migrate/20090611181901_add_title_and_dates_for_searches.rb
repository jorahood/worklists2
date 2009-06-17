class AddTitleAndDatesForSearches < ActiveRecord::Migration
  def self.up
    change_table(:searches) do |t|
      t.column :title_search, :string
      t.column :birthdate, :date
      t.column :modifieddate, :datetime
      t.column :approveddate, :date
    end
  end

  def self.down
      change_table(:searches) do |t|
      t.remove :title_search
      t.remove :birthdate
      t.remove :modifieddate
      t.remove :approveddate
    end
  end
end
