class DocidSearch < ActiveRecord::Base

  hobo_model # Don't put anything above this

  set_primary_keys :doc_id, :search_id

  belongs_to :doc
  belongs_to :search
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
