class ListedDoc < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    timestamps
    workstate enum_string(:untouched,:pending,:completed)
  end

  belongs_to :doc
  belongs_to :list
  has_many :notes
  has_many :tags
  
  @@delegated_accessors = List.showable_columns - [:notes, :workstate, :tags]

  cattr_reader :delegated_accessors

  @@delegated_accessors.each do |method|
    delegate method, :to => :doc
  end

  def clone_notes(v1_listed_doc)
    if ownernote_text = v1_listed_doc['notes']
      self.notes << Note.new(:text => ownernote_text)
    end
    if editornote_text = v1_listed_doc['editornotes']
      self.notes << Note.new(:text => editornote_text)
    end
  end
  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator? || list.creator_is?(acting_user)
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator? || list.creator_is?(acting_user)
  end

  def view_permitted?(field)
    true
  end

  def name
    "#{doc.id} in '#{list.name}'"
  end
end
