class DocidSearch < ActiveRecord::Base

  hobo_model # Don't put anything above this

  belongs_to :doc
  belongs_to :search
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
