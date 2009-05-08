class Volatility < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    id :integer
    name  :string
  end

  set_table_name :volatility
  set_search_columns nil

  has_many :docs

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
