class Volatility < Kb3

  hobo_model # Don't put anything above this

  fields do
    rank :integer
    volatility  :string, :name => true
  end

  set_table_name :volatility
  set_search_columns nil

  has_many :docs, :foreign_key => 'volatility'

  set_primary_key :rank

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
