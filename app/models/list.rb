class List < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :string
    comment :text
    timestamps
    show_approveddate :boolean
    show_author :boolean
    show_boiler :boolean
    show_birthdate :boolean
    show_domains :boolean
    show_expirations :boolean
    show_hotitems :boolean
    show_importance :boolean
    show_kbas :boolean
    show_kba_bys :boolean
    show_modifieddate :boolean
    show_notes :boolean
    show_owner :boolean
    show_refs :boolean
    show_refbys :boolean
    show_referenced_boilers :boolean
    show_resources :boolean
    show_status :boolean
    show_tags :boolean
    show_titles :boolean
    show_visibility :boolean
    show_volatility :boolean
    show_xtras :boolean
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
    :through => :listed_docs
  
  def before_save
    if changed.include?("search_id")
      populate! if search
    end
  end

  def populate!
    #FIXME: the following is too slow for 1000+ doc lists,
    #for speed use ActiveRecord::Base#import provided by ar_extensions
    self.docs = search.execute
  end

  def refresh_search
    populate!
    save!
  end
  # --- Permissions --- #

  def create_permitted?
    owner_is?(acting_user)
  end

  def update_permitted?
    !owner.changed? || acting_user.administrator?
  end

  def destroy_permitted?
    true
  end

  def view_permitted?(field)
    true
  end

  def refresh_search_permitted?
    owner_is?(acting_user) || acting_user.administrator?
  end

end
