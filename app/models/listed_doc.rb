class ListedDoc < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    timestamps
    workstate enum_string(:untouched,:pending,:completed)
  end

  belongs_to :doc
  belongs_to :list
  has_many :notes, :dependent => :destroy
  has_many :taggings
  has_many :tags,
    :through => :taggings
  
  @@delegated_accessors = List.showable_columns - [:notes, :workstate, :tags]

  cattr_reader :delegated_accessors

  @@delegated_accessors.each do |method|
    delegate method, :to => :doc
  end

  DefaultDocidUrl = 'https://bell.ucs.indiana.edu/workshop/workshop.cgi?id=%k&amp;openDoc=Open+document+ID&amp;rm=documentDisplaySimple'

  def do_clone(v1_listed_doc)
    clone_notes(v1_listed_doc)
    clone_tags(v1_listed_doc)
    clone_workstate(v1_listed_doc)
  end

  def clone_notes(v1_listed_doc)
    if ownernote_text = v1_listed_doc['notes']
      self.notes << Note.new(:text => ownernote_text, :creator => Kbuser.find_by_username('kb'))
    end
    if editornote_text = v1_listed_doc['editornotes']
      self.notes << Note.new(:text => editornote_text,  :creator => Kbuser.find_by_username('kb'))
    end
  end

  def clone_tags(v1_listed_doc)
    if tag_name = v1_listed_doc['category']
      self.tags << Tag.find_or_create_by_name(tag_name)
    end
  end

  def clone_workstate(v1_listed_doc)
    if v1_listed_doc['done']
      self.workstate = 'completed'
    elsif v1_listed_doc['notes']
      self.workstate = 'pending'
    else
      self.workstate = 'untouched'
    end
  end

  def make_docid_link
    url = list.custom_url.blank? ? DefaultDocidUrl : list.custom_url
    url.sub(/%k/, docid)
  end

  named_scope :sort_by_doc_metadata, lambda { |sort_by|
    # sort_by is the result of Hobo::ModelController.parse_sort_param
    # it looks like [@sort_field, @sort_direction], e.g., ["doc.modifieddate", "asc"]
    if !sort_by.blank?
      # pluralize doc to docs
      klass=sort_by.first.split(".").first
      # this is just a reusable way of changing the string "doc"
      # into the name of the Doc model table, "document"
      sort_by.first.gsub!(klass, klass.classify.constantize.table_name)
      # now sort_by looks like "docs.modifieddate asc"
      {:include => :doc, :order => sort_by.join(' ')}
    else
      nil
    end
  }
  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator? || list.creator_is?(acting_user)
  end

  def update_permitted?
    acting_user.administrator? || list.creator_is?(acting_user)
  end

  def destroy_permitted?
    acting_user.administrator? 
  end

  def view_permitted?(field)
    true
  end

  def name
    "#{doc.id} in '#{list.name}'"
  end
end
