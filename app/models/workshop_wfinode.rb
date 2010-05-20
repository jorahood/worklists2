class WorkshopWfinode < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    desk         :integer
    parent       :integer
    creator      :string
    owner        :string, :name=> true
    usergroup    :string
    birthdate    :date
    lastmodified :date
    permissions  :integer
  end

  set_table_name :wfinode

  def self.import_from_bell
    true
  end

  has_many :workshop_document_assets,
    :foreign_key => "id"
  has_many :docs,
    :through => :workshop_document_assets
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
