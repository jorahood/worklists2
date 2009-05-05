class Hotitem < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :string
  end

  set_search_columns nil

  belongs_to :doc

  set_primary_key :name

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
