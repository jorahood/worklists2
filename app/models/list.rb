class List < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :string
    comment :text
    timestamps
  end

  validates_presence_of :name, :owner

  belongs_to :owner,
    :class_name => "User",
    # FIXME: foreign_key option required because of monkey_patching of
    # ActiveRecord::Reflection::AssociationReflection#primary_key_name by
    # composite_primary_keys gem .
    :foreign_key => 'owner_id',
    :creator => true
  belongs_to :audience
  belongs_to :search
  
  has_many :listed_docs,
    :dependent => :destroy
  has_many :docs, 
    :through => :listed_docs,
    :accessible => true
  
  #  def  before_create
  #    self.populate! if self.search
  #  end

  def before_save
    if changed.include?("search_id")
      old_search = changes["search_id"][0]
      depopulate!(old_search) if old_search
      populate! if search
    end
  end

  def depopulate!(from_search)
    self.docs = []
  end
  
  def populate!
    #FIXME: the following is too slow for 1000+ doc lists, 
    #for speed use ActiveRecord::Base#import provided by ar_extensions
    self.docs = self.search.execute
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
