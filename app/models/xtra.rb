class Xtra < Kb3

  hobo_model # Don't put anything above this

  fields do
    term   :string, :name => true
    weight :integer
  end

  set_primary_keys :term, :id
  set_table_name :xtra
  set_search_columns nil

  belongs_to :doc,
    :foreign_key => 'id'

  def self.import_from_bell
    true
  end

  # hacking compatibility with composite primary keys for Hobo. Hobo tries to
  # instantiate a new record when checking view permissions when rendering
  # lists/show.dryml and doesn't know to use two ids.
  def id=(id)
    return true
  end
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
