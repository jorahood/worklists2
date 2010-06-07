class Kbresource < Kb3
  #FIXME: this should be named resourced_docs to mirror domained_docs
  hobo_model # Don't put anything above this

  set_table_name :kbresource
  belongs_to :doc, :foreign_key => 'id'
  belongs_to :kbuser, :foreign_key => 'username'
  set_primary_keys :id, :username

  has_many :searches
  
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
