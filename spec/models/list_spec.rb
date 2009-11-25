require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe List do
  before(:each) do
    @list_creator = mock_model(Kbuser, :administrator? => false, :signed_up? => true, :name=>'List creator')
    @doc = mock_model(Doc, :id => 'mock')
    @other_doc = mock_model(Doc, :id => 'othr')
    @search = mock_model(Search, :execute => [@doc])
    @list = List.create!(:name=>'test', :creator=>@list_creator)
  end
  it { should respond_to :name }
  it { should respond_to :creator }
  it { should respond_to :comment }
  it { should respond_to :show_docid }
  it { should respond_to :show_tags }
  it { should respond_to :wl1_import }
  it { should respond_to :wl1_clone }
  it { should validate_presence_of :name }
  it { should validate_presence_of :creator }
  it { should validate_numericality_of :wl1_import }
  it { should belong_to :creator }
  specify "creator should be a Kbuser" do
    @list.creator.class.should == Kbuser
  end
  it { should have_many :listed_docs }
  it { should have_many(:docs).through :listed_docs }
  it { should belong_to :search }
  it "should return showable metadata columns" do
    columns = List.attr_order.*.to_s.grep(/^show_/) do |method_name|
      method_name.gsub(/^show_/,'').to_sym
    end
    List.showable_columns.should_not == []
    List.showable_columns.should == columns
  end
  it "should return selected showable metadata columns" do
    columns = List.showable_columns.find_all do |column|
      subject.send("show_#{column}".to_sym)
    end
    subject.selected_columns.should_not == []
    subject.selected_columns.should == columns
  end

  context "Permissions" do
    Spec::Matchers.define :be_creatable do
      match do |model|
        model.create_permitted?
      end
    end
    before(:each) do
      @admin = mock_model(Kbuser, :administrator? => true, :signed_up? => true)
      @other_Kbuser = mock_model(Kbuser, :administrator? => false, :signed_up? => true)
      @guest = mock_model(Guest, :signed_up? => false)
    end
    it "should be creatable by its creator" do
      @list.stub!(:acting_user).and_return(@list_creator)
      @list.should be_creatable_by(@list_creator)
    end
    it "should not be creatable by non-creator" do
      # this helps hobo know that the current Kbuser can create their own projects
      # only, and the creator field shouldn't be displayed on the new list form
      @list.should_not be_creatable_by(@other_Kbuser)
    end
    it "should not be creatable by guest" do
      @list.should_not be_creatable_by(@guest)
    end
    specify "search should be refreshable by creator" do
      @list.method_callable_by?(@list_creator, :refresh_search).should be_true
    end
    specify "search should not be refreshable by non-creator" do
      @list.method_callable_by?(@other_Kbuser, :refresh_search).should be_false
    end
    
    context "change creator" do
      before do
        @list_creator.stub!(:changed? => true)
      end
      it "should not allow non-admin Kbusers" do
        @list.should_not be_updatable_by(@list_creator)
      end
      it "should allow admin Kbuser" do
        @list.should be_updatable_by(@admin)
      end
    end
    
    #    it "should be updatable by creator" do
    #      @list.updatable_by?(@Kbuser,nil).should be_true
    #    end
    #
    #    it "should be updatable by non-creator" do
    #      @list.updatable_by?(@other_Kbuser,nil).should be_true
    #    end
    #
    #    it "should be deletable by non-admin Kbuser it belongs to" do
    #      @list.deletable_by?(@Kbuser).should be_true
    #    end
    #
    #    it "should be deletable by admin" do
    #      @list.deletable_by?(@admin).should be_true
    #    end
    #
    #    it "should not be deletable by non-creator" do
    #      @list.deletable_by?(@other_Kbuser).should be_false
    #    end
    #
    #    it "should be viewable by guests" do
    #      @list.viewable_by?(@guest, nil).should be_true
    #    end
    #
    #    describe "updating docs" do
    #      it "should allow editing docs" do
    #        @list.docs_editable_by?(@Kbuser).should be_true
    #      end
    #    end
  end

  context "with a new search assigned" do
    before do
      @list.search = @search
    end
    it "should populate itself" do
      @list.should_receive(:populate!)
      @list.save!
    end
    it "should ask the search to execute" do
      @search.should_receive(:execute)
      @list.save!
    end
    it "should populate its listed docs with the docs from the search" do
      @list.save!
      @list.docs.should == [@doc]
    end

    context "saving an existing list" do
      before do
        @list.search = nil
        @list.save!
        @list.search = @search
      end
      it "should ask the search to execute" do
        @search.should_receive(:execute)
        @list.save!
      end
      it "should use the results retrieved from the search" do
        @list.save!
        @list.docs.should == [@doc]
      end
      context "belonging to a different search than last time it was saved" do
        before do
          @list.save!
          @a_different_search = mock_model(Search, :execute => [])
          @list.search = @a_different_search
        end
        it "should ask the search to execute" do
          @a_different_search.should_receive(:execute)
          @list.save!
        end
      end
    end
  end

  context "belonging to no search" do
    context "saving a new list" do
      it "should not try to populate itself" do
        @list.should_not_receive(:populate!)
        @list.save!
      end
    end

    context "not new" do
      before do
        @list.save!
      end
      it "should not try to populate itself" do
        @list.should_not_receive(:populate!)
        @list.save!
      end
    end
  end

  context "belonging to the same search as last save" do
    before do
      @list.search = @search
      @list.save!
    end
    it "should not try to populate itself" do
      @list.should_not_receive(:populate!)
      @list.save!
    end

    context "refreshing the search" do
      before do
        @search.stub!(:execute => [@doc, @other_doc])
      end
      it "should execute the search" do
        @search.should_receive(:execute)
        @list.refresh_search
      end
      it "should save!" do
        @list.should_receive(:save!)
        @list.refresh_search
      end
      it "should update its listed docs with the docs from the search" do
        @list.refresh_search
        @list.docs.should == [@doc, @other_doc]
      end
      it "should keep listed docs from refresh to refresh" do
        old_listed_doc = @list.docs.first
        @list.refresh_search
        @list.docs.first.should === old_listed_doc
      end
    end
  end
  
  context "cloning or importing a v1 worklist" do
    before do
      @v1list_hash = YAML.load_file(File.expand_path(File.dirname(__FILE__) + '/../fixtures/worklist11777.yml'))
      @list.stub(:request_and_load_yaml).with(11777).and_return(@v1list_hash)
      @sample_docs = []
      @v1list_hash["docs"].each do |attrs|
        @sample_docs << Factory.create(:doc, :id => attrs['id'])
      end
    end
    it "should do_import when wl1_import changed" do
      @list.should_receive(:do_import).with(100)
      @list.wl1_import = 100
      @list.save!
    end
    it "should do_clone when wl1_clone attr changed" do
      @list.should_receive(:do_clone).with(100)
      @list.wl1_clone = 100
      @list.save!
    end
    it "should try to find the docs in the yaml file" do
      Doc.should_receive(:find).with('awfj').and_return(Factory :doc)
      Doc.should_receive(:find).with('apev').and_return(Factory :doc)
      Doc.should_receive(:find).with('arxq').and_return(Factory :doc)
      Doc.should_receive(:find).with('avck').and_return(Factory :doc)
      @list.get_v1_list_and_find_docs(11777)
    end
    it "should request and load a yaml serialization of the v1 worklist when cloning" do
      @list.should_receive(:request_and_load_yaml).with(11777).and_return(@v1list_hash)
      @list.do_clone(11777)
    end
    it "should request and load a yaml serialization of the v1 worklist when importing" do
      @list.should_receive(:request_and_load_yaml).with(11777).and_return(@v1list_hash)
      @list.do_import(11777)
    end
    it "should set its docs to be the docs from the imported list" do
      @list.do_import(11777)
      @list.docs.should == @sample_docs
    end
    it "should add to its existing docs when importing, not replace them" do
      blah = Factory(:doc, :id => 'blah')
      @list.docs << blah
      @list.do_import(11777)
      @list.docs.sort_by{|doc|doc.id}.should == @sample_docs.unshift(blah).sort_by{|doc|doc.id}
    end
    it "should set its docs to be the docs from the cloned list" do
      @list.do_clone(11777)
      @list.docs.should == @sample_docs
    end
    it "should replace all of its existing docs when cloning, not add to them" do
      @list.docs << Factory(:doc, :id => 'blah')
      @list.do_clone(11777)
      @list.docs.should == @sample_docs
    end
    it "should set its comment to the comments of the cloned list" do
      @list.do_clone(11777)
      @list.comment.should == @v1list_hash['comments']
    end
  end
end