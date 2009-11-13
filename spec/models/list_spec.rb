require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe List do
  before(:each) do
    @list_owner = mock_model(User, :administrator? => false, :signed_up? => true, :name=>'List Owner')
    @doc = mock_model(Doc, :id => 'mock')
    @other_doc = mock_model(Doc, :id => 'othr')
    @search = mock_model(Search, :execute => [@doc])
    @list = List.new(:name=>'test', :owner=>@list_owner)
  end
  it { should respond_to :name }
  it { should respond_to :owner }
  it { should respond_to :comment }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:owner) }

  it { should belong_to(:owner)}
  specify "owner should be a User" do
    @list.owner.class.should == User
  end
  it { should have_many(:listed_docs)}
  it { should have_many(:docs).through(:listed_docs)}
  it { should belong_to(:search)}

  context "Permissions" do
    Spec::Matchers.define :be_creatable do
      match do |model|
        model.create_permitted?
      end
    end
    before(:each) do
      @admin = mock_model(User, :administrator? => true, :signed_up? => true)
      @other_user = mock_model(User, :administrator? => false, :signed_up? => true)
      @guest = mock_model(Guest, :signed_up? => false)
    end

    it "should be creatable by its owner" do
      @list.stub!(:acting_user).and_return(@list_owner)
      @list.should be_creatable_by(@list_owner)
    end
    
    it "should not be creatable by non-owner" do
      # this helps hobo know that the current user can create their own projects
      # only, and the Owner field shouldn't be displayed on the new list form
      @list.should_not be_creatable_by(@other_user)
    end
    it "should not be creatable by guest" do
      @list.should_not be_creatable_by(@guest)
    end
    specify "search should be refreshable by owner" do
      @list.method_callable_by?(@list_owner, :refresh_search).should be_true
    end
    specify "search should not be refreshable by non-owner" do
      @list.method_callable_by?(@other_user, :refresh_search).should be_false
    end
    
    context "change owner" do
      before do
        @list_owner.stub!(:changed? => true)
      end
      it "should not allow non-admin users" do
        @list.should_not be_updatable_by(@list_owner)
      end
    
      it "should allow admin user" do
        @list.should be_updatable_by(@admin)
      end
    end
    
    #    it "should be updatable by owner" do
    #      @list.updatable_by?(@user,nil).should be_true
    #    end
    #
    #    it "should be updatable by non-owner" do
    #      @list.updatable_by?(@other_user,nil).should be_true
    #    end
    #
    #    it "should be deletable by non-admin user it belongs to" do
    #      @list.deletable_by?(@user).should be_true
    #    end
    #
    #    it "should be deletable by admin" do
    #      @list.deletable_by?(@admin).should be_true
    #    end
    #
    #    it "should not be deletable by non-owner" do
    #      @list.deletable_by?(@other_user).should be_false
    #    end
    #
    #    it "should be viewable by guests" do
    #      @list.viewable_by?(@guest, nil).should be_true
    #    end
    #
    #    describe "updating docs" do
    #      it "should allow editing docs" do
    #        @list.docs_editable_by?(@user).should be_true
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
end