class Reference < Kb3

  hobo_model # Don't put anything above this

  set_primary_keys :fromid, :toid
  set_search_columns nil

  belongs_to :ref_doc,
    :class_name => 'Doc',
    :foreign_key => 'fromid'

  belongs_to :refby_doc,
    :class_name => 'Doc',
    :foreign_key => 'toid'

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
