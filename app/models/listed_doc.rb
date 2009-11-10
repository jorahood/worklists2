class ListedDoc < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    timestamps
    status enum_string(:untouched,:pending,:completed)
    tag :string
  end

  belongs_to :doc
  belongs_to :list
  has_many :notes

  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator? || list.owner_is?(acting_user)
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator? || list.owner_is?(acting_user)
  end

  def view_permitted?(field)
    true
  end

  def name
    "#{doc.id} in '#{list.name}'"
  end
end
