class Kbresource < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
  end

  set_table_name :kbresource
  belongs_to :doc, :foreign_key => 'id'
  belongs_to :kbuser, :foreign_key => 'username'

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
