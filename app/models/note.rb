class Note < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    text :text, :name => true
    timestamps
  end

  belongs_to :listed_doc
  belongs_to :owner,
    :class_name => 'User',
    # FIXME: foreign_key option required because of monkey_patching of
    # ActiveRecord::Reflection::AssociationReflection#primary_key_name by
    # composite_primary_keys gem .
    :foreign_key => 'owner_id',
    :creator => true
  
  # --- Permissions --- #

  def create_permitted?
    # keep the owner_is? acting_user line here even though it doesn't affect
    # permissions because Hobo uses it to automatically populate the owner
    # association with the current user.
    #
    # FIXME: figure out why owner_is? acting_user doesn't display an edit form
    # for a model in a has_many nested in a table-plus (E.g., New note in  a
    # listed_doc in a table of listed_docs for a list. Why, if I make the
    # owner_is? line the return value for create_permitted?, the new note form
    # doesn't get rendered in the cell? )
    owner_is? acting_user
    acting_user.signed_up?
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
