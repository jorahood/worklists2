class Audience < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    id  :string, :name => true
    description :string
  end

  set_search_columns nil

  has_many :titles
  has_many :lists
  
  # --- Permissions --- #

  def create_permitted?
    false
  end

  def update_permitted?
    false
  end

  def destroy_permitted?
    false
  end

  def view_permitted?(field)
    true
  end

end
