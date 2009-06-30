class List < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :string
    comment :text
    timestamps
  end

  #  validates_presence_of :name, :owner

  belongs_to :owner,
    :class_name => "User",
    :foreign_key => 'owner_id',
    :creator => true
  belongs_to :audience
  belongs_to :search

  has_many :listed_docs,
    :dependent=>:destroy
  has_many :docs, 
    :through =>:listed_docs,
    :accessible => true

#  accepts_nested_attributes_for :docs,
#    :allow_destroy => true

  def populate
    self.docs = search.perform
  end
  # --- Permissions --- #

  def create_permitted?
    true
  end

  def update_permitted?
    true
  end

  def destroy_permitted?
    true
  end

  def view_permitted?(field)
    true
  end


end
