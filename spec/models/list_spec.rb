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
  it "should give unnamed lists a generic name on create" do
    list = List.create!
    list.name.should_not be_blank
  end
  it "should not try to give an existing list a new name when name is deleted" do
    list = List.create!
    list.name = nil
    lambda {
      list.save!
    }.should raise_error("Validation failed: Name can't be blank")
  end
  it "should validate presence of name" do
    # this is a hack. The create_temp_name only fires on
    # before_validation_on_create, so I will test that name is validated when
    # not creating in order to not fire create_temp_name. This technique is my
    # solution for the fact that  List.before_validation_on_create.clear
    # interferes with later tests that depend on create_temp_name to create the
    # name and I don't know how to restore the callbacks after calling clear

    list = List.create!(:name => 'blah')
    list.name = nil
    lambda {
      list.save!
    }.should raise_error("Validation failed: Name can't be blank")
  end
  it { should validate_numericality_of :wl1_import }
  it { should validate_numericality_of :wl1_clone }
  it "should validate uniqueness of :wl1_clone when not nil" do
    list =  List.create!(:wl1_clone => 1)
    lambda {
      List.create!(:wl1_clone => 1)
    }.should raise_error(/That list has already been cloned/)
  end
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
      @list.should_receive(:populate)
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
  
  context "wl1" do
    before do
      @sample_list = YAML.load_file(File.expand_path(File.dirname(__FILE__) + '/../fixtures/worklist11777.yml'))
      @sample_docs = []
      @sample_list["docs"].each do |attrs|
        @sample_docs << Factory.create(:doc, :id => attrs['id'])
      end
    end

    context "importing" do
      before do
        @list.wl1_import = 11777
      end
      it "should do_import when wl1_import is changed and exists" do
        @list.should_receive(:do_import)
        @list.save!
      end
      it "should not do_import when wl1_import is not changed" do
        @list.save!
        @list.should_not_receive(:do_import)
        @list.save!
      end
      it "should not do_import when wl1_import is removed" do
        @list.save!
        @list.should_not_receive(:do_import)
        @list.wl1_import = nil
        @list.save!
      end
      it "should try to find the docs in the yaml file" do
        @list.stub(:request_and_load_yaml).and_return(@sample_list)
        Doc.should_receive(:find).with('awfj').and_return(Factory :doc)
        Doc.should_receive(:find).with('apev').and_return(Factory :doc)
        Doc.should_receive(:find).with('arxq').and_return(Factory :doc)
        Doc.should_receive(:find).with('avck').and_return(Factory :doc)
        @list.do_import
      end
      it "should request and load a yaml serialization of the v1 worklist when importing" do
        @list.should_receive(:request_and_load_yaml).and_return(@sample_list)
        @list.do_import
      end
      it "should set its docs to be the docs from the imported list" do
        @list.stub(:request_and_load_yaml).and_return(@sample_list)
        @list.do_import
        @list.docs.should == @sample_docs
      end
      it "should add to its existing docs when importing, not replace them" do
        @list.stub(:request_and_load_yaml).and_return(@sample_list)
        blah = Factory(:doc, :id => 'blah')
        @list.docs << blah
        @list.do_import
        @list.docs.sort_by{|doc|doc.id}.should == @sample_docs.unshift(blah).sort_by{|doc|doc.id}
      end
      it "should not raise a RecordNotFound error if a doc to be imported doesn't exist" do
        @sample_list['docs'][0]['id'] = 'zzzz'
        @list.stub(:request_and_load_yaml).and_return(@sample_list)
        lambda {@list.do_import}.should_not raise_error(ActiveRecord::RecordNotFound)
      end
      specify "should catch errors generated from trying to retrieve a list" do
        @list.stub(:get_v1_list_and_find_docs).and_raise
        lambda {
          @list.do_import
        }.should_not raise_error RuntimeError
      end
      it "should skip docids that don't exist" do
        @sample_list['docs'] << {'id' => 'zzzz'}
        @list.stub(:request_and_load_yaml).and_return(@sample_list)
        @list.do_import
        @list.docs.should == @sample_docs
      end
    end    
 
    context "cloning" do
      before do
        @list.wl1_clone = 11777
      end
      it "should do_clone when wl1_clone attr changed" do
        @list.should_receive(:do_clone)
        @list.save!
      end
      it "should not do_clone when wl1_clone is not changed" do
        @list.save!
        @list.should_not_receive(:do_clone)
        @list.save!
      end
      it "should not do_clone when wl1_clone is removed" do
        @list.save!
        @list.should_not_receive(:do_clone)
        @list.wl1_clone = nil
        @list.save!
      end
      it "should request and load a yaml serialization of the v1 worklist when cloning" do
        @list.should_receive(:request_and_load_yaml).and_return(@sample_list)
        @list.do_clone
      end
      it "should set its docs to be the docs from the cloned list" do
        @list.stub(:request_and_load_yaml).and_return(@sample_list)
        @list.do_clone
        @list.docs.should == @sample_docs
      end
      it "should not raise an error if a doc to be cloned doesn't exist" do
        @sample_list['docs'][0]['id'] = 'zzzz'
        @list.stub(:request_and_load_yaml).and_return(@sample_list)
        lambda {@list.do_clone}.should_not raise_error(ActiveRecord::RecordNotFound)
      end
      it "should skip docids that don't exist" do
        @sample_list['docs'] << {'id' => 'zzzz'}
        @list.stub(:request_and_load_yaml).and_return(@sample_list)
        @list.do_clone
        @list.docs.should == @sample_docs
        @list.listed_docs.count.should == @sample_docs.count
      end
      it "should replace all of its existing docs when cloning, not add to them" do
        @list.stub(:request_and_load_yaml).and_return(@sample_list)
        blah = Factory(:doc, :id => 'blah')
        @list.docs << blah
        @list.do_clone
        @list.docs.should_not include blah
      end
      it "should set its comment to the comments of the cloned list" do
        @list.stub(:request_and_load_yaml).and_return(@sample_list)
        @list.do_clone
        @list.comment.should == @sample_list['comments']
      end
      it "should set its name to the name of the cloned list" do
        @list.stub(:request_and_load_yaml).and_return(@sample_list)
        @list.do_clone
        @list.name.should == @sample_list['name']
      end
      specify "get_v1_list_and_find_docs should throw an exception if it can't parse the results of the fetch" do
        url = 'https://kbhandbook.indiana.edu/worklist/12'
        lambda {
          @list.get_v1_list_and_find_docs(12)
        }.should raise_error
      end
      specify "do_clone should catch errors from trying to retrieve a list" do
        @list.stub(:get_v1_list_and_find_docs).and_raise
        lambda {
          @list.do_clone
        }.should_not raise_error(RuntimeError)
      end
    end
  end
end