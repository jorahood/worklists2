class List < ActiveRecord::Base

  hobo_model # Don't put anything above this

  include XmlUtilities
  
  fields do
    name :string
    comment :text
    timestamps
    show_approveddate :boolean, :default => true
    show_author :boolean
    show_boilers :boolean
    show_birthdate :boolean
    show_domains :boolean, :default => true
    show_docid :boolean, :default => true
    show_expirations :boolean
    show_hotitems :boolean
    show_importance :boolean
    show_kbas :boolean
    show_kba_bys :boolean
    show_modifieddate :boolean, :default => true
    show_notes :boolean, :default => true
    show_owner :boolean, :default => true
    show_refs :boolean
    show_refbys :boolean
    show_referenced_boilers :boolean
    show_resources :boolean
    show_status :boolean
    show_tags :boolean, :default => true
    show_titles :boolean, :default => true
    show_visibility :boolean, :default => true
    show_volatility :boolean
    show_workstate :boolean, :default => true
    show_xtras :boolean
    wl1_import :integer
    wl1_clone :integer
  end

  never_show :show_docid
  
  validates_presence_of :name, :creator
  validates_numericality_of :wl1_import,
    :allow_nil => true
  
  belongs_to :audience
  belongs_to :search
  belongs_to :creator,
    :class_name => "Kbuser",
    # FIXME: foreign_key option required because of monkey_patching of
  # ActiveRecord::Reflection::AssociationReflection#primary_key_name by
  # composite_primary_keys gem .
  :foreign_key => 'creator_id',
    :creator => true
  
  has_many :listed_docs,
    :dependent => :destroy
  has_many :docs, 
    :through => :listed_docs

  def self.showable_columns
    attr_order.*.to_s.grep(/^show_/) do |method_name|
      method_name.gsub(/^show_/,'').to_sym
    end
  end

  before_save :populate_if_search_changed,
    :do_import_if_wl1_import,
    :do_clone_if_wl1_clone

  def populate_if_search_changed
    if changed.include?("search_id")
      populate! if search
    end
  end

  def do_import_if_wl1_import
    do_import(wl1_import) if wl1_import
  end
  
  def do_clone_if_wl1_clone
    do_clone(wl1_clone) if wl1_clone
  end

  def selected_columns
    List.showable_columns.find_all do |column|
      self.send("show_#{column}".to_sym)
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

  def do_import(wl1id)
    wl1hash = request_and_load_yaml(wl1id)
    wl1docs = wl1hash["docs"].map {|doc_attrs| Doc.find(doc_attrs["id"]) }
    self.docs << wl1docs
  end

  def do_clone(wl1id)
    wl1hash = request_and_load_yaml(wl1id)
    wl1docs = wl1hash["docs"].map {|doc_attrs| Doc.find(doc_attrs["id"]) }
    self.docs = wl1docs
    self.docs.each do |assoc_doc|
    end
  end

  # --- Permissions --- #

  def create_permitted?
    creator_is? acting_user
  end

  def update_permitted?
    !creator.changed? || acting_user.administrator?
  end

  def destroy_permitted?
    true
  end

  def view_permitted?(field)
    true
  end

  def refresh_search_permitted?
    creator_is? acting_user || acting_user.administrator?
  end

end
