class List < ActiveRecord::Base

  hobo_model # Don't put anything above this

  include XmlUtilities
  
  fields do
    name :string
    comment :text
    timestamps
    show_docid :boolean, :default => true
    show_titles :boolean, :default => true
    show_approveddate :boolean, :default => true
    show_modifieddate :boolean, :default => true
    show_birthdate :boolean
    show_domains :boolean, :default => true
    show_owner :boolean, :default => true
    show_author :boolean
    show_refs :boolean
    show_refbys :boolean
    show_boilers :boolean
    show_referenced_boilers :boolean
    show_expirations :boolean
    show_hotitems :boolean
    show_importance :boolean
    show_resources :boolean
    show_status :boolean
    show_visibility :boolean, :default => true
    show_volatility :boolean
    show_kbas :boolean
    show_kba_bys :boolean
    show_xtras :boolean
    show_tags :boolean, :default => true
    show_notes :boolean, :default => true
    show_workstate :boolean, :default => true
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

  before_save :populate, :if => :new_search?
  before_save  :do_import, :if => :new_import?
  before_save  :do_clone, :if => :new_clone?

  def new_search?
    search && search_id_changed?
  end

  def new_import?
    wl1_import && wl1_import_changed?
  end

  def new_clone?
    wl1_clone && wl1_clone_changed?
  end

  def selected_columns
    List.showable_columns.find_all do |column|
      self.send("show_#{column}".to_sym)
    end
  end

  def populate
    #FIXME: the following is too slow for 1000+ doc lists,
    #for speed use ActiveRecord::Base#import provided by ar_extensions
    self.docs = search.execute
  end

  def refresh_search
    populate
    save!
  end

  def request_and_load_yaml(wl1_id)
    response = fetch_url("#{WL1_URL}/#{wl1_id}/yaml")
    YAML.load(response.body)
  end

  def get_v1_list_and_find_docs(wl1_id)
    wl1hash = request_and_load_yaml(wl1_id)
    wl1hash['doc_objects'] = wl1hash["docs"].map {|doc_attrs| Doc.find(doc_attrs["id"]) }
    wl1hash
  end

  def do_import
    v1_list = get_v1_list_and_find_docs(wl1_import)
    self.docs << v1_list['doc_objects']
  end

  def do_clone
    v1_list = get_v1_list_and_find_docs(wl1_clone)
    self.comment = v1_list['comments']
    self.name = v1_list['name']
    listed_docs = []
    v1_list['docs'].each do |doc|
      listed_doc = ListedDoc.new(:list_id => self.id, :doc_id => doc['id'])
      listed_doc.do_clone(doc)
      listed_doc.save
      listed_docs << listed_doc
    end
    self.listed_docs = listed_docs
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
