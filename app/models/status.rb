class Status < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    rank :integer
    status :string, :name => true
  end

  set_table_name :status
  set_search_columns nil

  has_many :docs, :foreign_key => 'status'

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
