class Kbresource < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
  end

  set_table_name :kbresource
  belongs_to :doc
  belongs_to :kbuser

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
