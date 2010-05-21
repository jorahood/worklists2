class Kb3Event < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    action    :string
    fielda    :string
    fieldb    :string
    timestamp :datetime
    type      :string
    version   :string
  end

  set_table_name :event

  def self.import_from_bell
    true
  end

  belongs_to :doc,
    :foreign_key => "id"
  belongs_to :kbuser,
    :foreign_key => "editor"

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
