class Note < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    text :text, :name => true
    timestamps
  end

  belongs_to :listed_doc
  belongs_to :owner,
    :class_name => 'User',
    :foreign_key => 'owner_id',
    :creator => true
  
    # --- Permissions --- #

  def create_permitted?
    return true if acting_user.administrator?

    owner_is? acting_user
  end

  def update_permitted?
    return true if acting_user.administrator?

    acting_user.signed_up?
  end

  def destroy_permitted?
    return true if acting_user.administrator?

    !owner_changed?
  end

  def view_permitted?(field)
    true
  end

end
