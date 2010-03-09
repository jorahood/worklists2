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
    custom_url :string
  end

  never_show :show_docid
  
  validates_presence_of :name
  validates_numericality_of :wl1_import, :wl1_clone,
    :allow_nil => true
  validates_uniqueness_of :wl1_clone, :allow_blank => true, :message => "That list has already been cloned"
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
  before_save  :do_clone, :if => :wl1_clone
  before_validation_on_create :create_temp_name, :if => "name.blank?"

  def create_temp_name
    self.name = "whatevs, can't be bothered to name my list"
  end

  def new_search?
    search && search_id_changed?
  end

  def new_import?
    wl1_import && wl1_import_changed?
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

  def get_v1_list_and_find_docs(wl1_id)
    yaml = nil
    yaml = request_and_load_yaml(wl1_id)
    raise "could not retrieve list #{wl1_id}. Result should be a hash, but received #{yaml}" unless yaml.instance_of? Hash
    yaml['doc_objects'] = []
    #delete docs that don't exist in the db
    yaml['docs'].delete_if do |doc_attrs|
      !Doc.exists?(doc_attrs['id'])
    end
    yaml["docs"].each do |doc_attrs|
      begin
        doc = Doc.find(doc_attrs["id"])
      rescue ActiveRecord::RecordNotFound => ex
        next
      end
      yaml['doc_objects'] << doc
    end
    yaml
  end
  
  def do_import
    begin
      v1_list = get_v1_list_and_find_docs(wl1_import)
    rescue RuntimeError => ex # couldn't retrieve list because it wasn't a hash
      return nil
    end
    self.docs << v1_list['doc_objects']
  end

  def do_clone
    v1_list = {}
    begin
      v1_list = get_v1_list_and_find_docs(wl1_clone)
    rescue RuntimeError => ex # couldn't retrieve list because it wasn't a hash
      return nil
    end
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
    search && acting_user.signed_up?
    #   creator_is? acting_user || acting_user.administrator?
  end

end
