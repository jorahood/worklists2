class DomainedDoc < Kb3

  hobo_model # Don't put anything above this

  fields do
  end

  set_table_name :documentdomain
  belongs_to :doc, :foreign_key => 'id'
  belongs_to :domain, :foreign_key => 'domain'

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
