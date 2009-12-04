require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ListedDoc do
    before do
      @admin = mock_model(Kbuser, :username=>'Admin', :signed_up? => true, :administrator? => true)
      @list_creator = mock_model(Kbuser, :username=>'Chuck', :signed_up? => true, :administrator? => false)
      @other_user = mock_model(Kbuser, :username=>'Bob', :signed_up? => true, :administrator? => false)
      @list = mock_model(List, :name=>'test', :creator_is? =>@list_creator)
      @doc = mock_model(Doc, :docid=>'blah', :title=>'blahblah')
      subject.list = @list
    end

  it {should respond_to :workstate}
  it "should delegate doc metadata accessors" do
    subject.should respond_to *ListedDoc.delegated_accessors
  end
  #  it {should validate_presence_of :list}
  #  it {should validate_presence_of :doc}
  it { should belong_to :doc }
  it { should belong_to :list }
  it { should have_many :notes }
  it { should have_many :tags }

  context "Permissions" do
    it { should be_creatable_by @list_creator }
    #    it "should not be creatable by non-admin list non-creator" do
    #      @listed_doc.creatable_by?(@other_user).should be_false
    #    end
    #
    #    it "should be creatable by admin" do
    #      @listed_doc.creatable_by?(@admin).should be_true
    #    end
    #
    #    it "should be updatable by list creator" do
    #      @listed_doc.updatable_by?(@list_creator,@listed_doc).should be_true
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
    #        @listed_doc.updatable_by?(@list_creator,@listed_doc_w_note).should be_true
    #      end
    #
    #      it "should not allow non-admins to remove notes" do
    #        @listed_doc_w_note.updatable_by?(@list_creator,@listed_doc).should be_false
    #      end
    #
    #      it "should allow admins to remove notes" do
    #        @listed_doc_w_note.updatable_by?(@admin,@listed_doc).should be_true
    #      end
    #    end
    #
    #    # Since the listed_doc is just a join model, it shouldn't let users change its associations
    #    it "should not allow non-admin to update list" do
    #      @listed_doc.updatable_by?(@list_creator,ListedDoc.new(:doc=>@doc, :list=>mock_model(List))).should be_false
    #    end
    #
    #    it "should not allow non-admin to update doc" do
    #      @listed_doc.updatable_by?(@list_creator,ListedDoc.new(:list=>@list, :doc=>mock_model(Doc))).should be_false
    #    end
    #
    #    it "should allow admin to update list" do
    #      @listed_doc.updatable_by?(@admin,ListedDoc.new(:doc=>@doc, :list=>mock_model(List))).should be_true
    #    end
    #
    it { should be_updatable_by @admin }
    it { should be_destroyable_by @list_creator }
  end

  context "in a cloned list" do
    before do
      @v1_list_hash = YAML.load_file(File.expand_path(File.dirname(__FILE__) + '/../fixtures/worklist11777.yml'))
      @v1_apev = @v1_list_hash['docs'][1]
      @v1_arxq = @v1_list_hash['docs'][2]
    end
    it "should get its notes from the notes of the doc in the imported v1 list" do
      subject.clone_notes(@v1_apev)
      subject.notes[0].should_not be_nil
      subject.notes[0].text.should == @v1_apev['notes']
    end
    it "should create a note for ownernotes first and for editornotes second" do
      subject.clone_notes(@v1_apev)
      subject.notes[0].should_not be_nil
      subject.notes[1].should_not be_nil
      subject.notes[0].text.should == @v1_apev['notes']
      subject.notes[1].text.should == @v1_apev['editornotes']
    end
    it "should only clone existing notes" do
      subject.clone_notes(@v1_arxq)
      subject.notes[0].should_not be_nil
      subject.notes[1].should be_nil
      subject.notes[0].text.should == @v1_arxq['notes']
    end
    it "should make the kbuser 'kb' the creator of cloned notes" do
      kb = Factory(:kbuser, :username => 'kb')
      subject.clone_notes(@v1_arxq)
      subject.notes[0].should_not be_nil
      subject.notes[0].creator.should == kb
    end
  end
end
