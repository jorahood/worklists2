class UsedBoiler < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
  end

  set_table_name :boilerusage
  belongs_to :doc, :foreign_key => 'fromid'
  belongs_to :boiler, :foreign_key => 'boiler'

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
