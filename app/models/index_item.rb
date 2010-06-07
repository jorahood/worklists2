class IndexItem < Kb3

  hobo_model # Don't put anything above this

  fields do
    word  :string
    score :decimal
  end

  set_table_name :indexitem
  
  belongs_to :doc,
    :foreign_key => :docid
  
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
