class Visibility < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    rank :integer
    visibility :string, :name => true
  end

  set_table_name :visibility
  set_search_columns nil

  has_many :docs, :foreign_key => 'visibility'

  set_primary_key :rank
  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

end
