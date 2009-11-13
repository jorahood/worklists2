require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ListedDoc do

  it {should respond_to :workstate}

  it "should delegate doc metadata accessors" do
    subject.should respond_to *ListedDoc.delegated_accessors
  end
  #  it {should validate_presence_of :list}
  #  it {should validate_presence_of :doc}
  it { should belong_to :doc }
  it { should belong_to :list }
  it { should have_many :notes }

  context "Permissions" do
    before do
      @listed_doc =  ListedDoc.new
      @admin = mock_model(User, :name=>'Admin', :signed_up? => true, :administrator? => true)
      @list_owner = mock_model(User, :name=>'Chuck', :signed_up? => true, :administrator? => false)
      @other_user = mock_model(User, :name=>'Bob', :signed_up? => true, :administrator? => false)
      @list = mock_model(List, :name=>'test', :owner_is? =>@list_owner)
      @doc = mock_model(Doc, :docid=>'blah', :title=>'blahblah')
      @listed_doc.list = @list
    end

    specify { @listed_doc.should be_creatable_by @list_owner }
    
    #    it "should not be creatable by non-admin list non-owner" do
    #      @listed_doc.creatable_by?(@other_user).should be_false
    #    end
    #
    #    it "should be creatable by admin" do
    #      @listed_doc.creatable_by?(@admin).should be_true
    #    end
    #
    #    it "should be updatable by list owner" do
    #      @listed_doc.updatable_by?(@list_owner,@listed_doc).should be_true
    #    end
    #
    #
    #    describe "updating notes:" do
    #      before do
    #        @listed_doc.doc = @doc
    #        @note = mock_model(Note)
    #        @listed_doc_w_note = ListedDoc.new(:list=>@list,:doc=>@doc, :notes=>[@note])
    #      end
    #
    #      it "should allow adding notes" do
    #        @listed_doc.updatable_by?(@list_owner,@listed_doc_w_note).should be_true
    #      end
    #
    #      it "should not allow non-admins to remove notes" do
    #        @listed_doc_w_note.updatable_by?(@list_owner,@listed_doc).should be_false
    #      end
    #
    #      it "should allow admins to remove notes" do
    #        @listed_doc_w_note.updatable_by?(@admin,@listed_doc).should be_true
    #      end
    #    end
    #
    #    # Since the listed_doc is just a join model, it shouldn't let users change its associations
    #    it "should not allow non-admin to update list" do
    #      @listed_doc.updatable_by?(@list_owner,ListedDoc.new(:doc=>@doc, :list=>mock_model(List))).should be_false
    #    end
    #
    #    it "should not allow non-admin to update doc" do
    #      @listed_doc.updatable_by?(@list_owner,ListedDoc.new(:list=>@list, :doc=>mock_model(Doc))).should be_false
    #    end
    #
    #    it "should allow admin to update list" do
    #      @listed_doc.updatable_by?(@admin,ListedDoc.new(:doc=>@doc, :list=>mock_model(List))).should be_true
    #    end
    #
    specify { @listed_doc.should be_updatable_by @admin }
    specify { @listed_doc.should be_destroyable_by @list_owner }
  end
end
