class ResourceSearch < ActiveRecord::Base

  hobo_model # Don't put anything above this

  belongs_to :search
  belongs_to :resource,
             :class_name => "Kbuser",
             :foreign_key => "resource_id"

  # --- Permissions --- #

  def create_permitted?
    true
  end

  def update_permitted?
    true
  end

  def destroy_permitted?
    true
  end

  def view_permitted?(field)
    true
  end

end
