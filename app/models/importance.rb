class Importance < Kb3

  hobo_model # Don't put anything above this

  fields do
    rank :integer
    importance :string, :name => true
  end

  set_table_name :importance
  set_search_columns nil

  set_primary_key :rank

  has_many :docs, :foreign_key => :importance # the fk in the document table

  def self.import_from_bell
    true
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
