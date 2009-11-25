require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe List do
  before(:each) do
    @list_creator = mock_model(Kbuser, :administrator? => false, :signed_up? => true, :name=>'List creator')
    @doc = mock_model(Doc, :id => 'mock')
    @other_doc = mock_model(Doc, :id => 'othr')
    @search = mock_model(Search, :execute => [@doc])
    @list = List.new(:name=>'test', :creator=>@list_creator)
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
  
  context "importing a v1 worklist" do
    it "should do_import when wl1_import changed" do
      @list.should_receive(:do_import).with(100)
      @list.wl1_import = 100
      @list.save!
    end

  end
  context "cloning a v1 worklist" do

  end
end