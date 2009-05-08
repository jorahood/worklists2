class List < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :string
    comment :text
    timestamps
  end

  validates_presence_of :name, :owner

  belongs_to :owner, :class_name => "User", :foreign_key => 'owner_id', :creator => true
  belongs_to :audience, :foreign_key => 'audience'

  has_many :listed_docs, :dependent=>:destroy
  has_many :docs, :through =>:listed_docs, :accessible => true

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
