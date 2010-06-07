class WorkshopDocumentAsset < Kb3

  hobo_model # Don't put anything above this

  fields do
    label :string
  end

set_table_name :documentasset

belongs_to :doc,
  :foreign_key => :document
belongs_to :workshop_wfinode,
  :foreign_key => :id

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
