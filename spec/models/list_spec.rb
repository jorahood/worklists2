require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe List do
  before(:each) do
    @list_owner = mock_model(User, :admin? => false, :signed_up? => true, :name=>'List Owner')
    @list = List.new(:name=>'test', :owner=>@list_owner)
  end
  specify { @list.should be_valid }
  it "should have a name" do
    @list.should respond_to(:name)
  end
  it "should have an owner" do
    @list.should respond_to(:owner)
  end
  it "should have a comment" do
    @list.should respond_to(:comment)
  end

  context "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:owner) }
  end

  context "Associations" do
    it { should belong_to(:owner)}
    specify "owner should be a User" do
      @list.owner.class.should == User 
    end
    it { should have_many(:listed_docs)}
    it { should have_many(:docs).through(:listed_docs)}
    it { should belong_to(:search)}
  end

  context "Permissions" do
    Spec::Matchers.define :be_creatable do 
      match do |model|
        model.create_permitted?
      end
    end
    before(:each) do
      @admin = mock_model(User, :admin? => true, :signed_up? => true)
      @other_user = mock_model(User,:admin? => false, :signed_up? => true)
      @guest = mock_model(Guest, :signed_up? => false)
      @updated_list_w_new_owner = List.new(:name=>'test', :owner=>@other_user)
    end
    it "should be creatable by its owner" do
      @list.stub!(:acting_user).and_return(@list_owner)
      @list.should be_creatable
    end
    #
    #    it "should not be creatable by non-owner" do
    #      # this helps hobo know that the current user can create their own projects
    #      # only, and the Owner field shouldn't be displayed on the new list form
    #        @list.creatable_by?(@other_user).should be_false
    #    end
    #
    #    it "should not be creatable by guest" do
    #      @list.creatable_by?(@guest).should be_false
    #    end
    #
    #    it "should not allow non-admins to change the owner" do
    #      @list.updatable_by?(@user,@updated_list_w_new_owner).should be_false
    #    end
    #
    #    it "should allow admin to change the owner" do
    #      @list.updatable_by?(@admin,@updated_list_w_new_owner).should be_true
    #    end
    #
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
      @doc = mock_model(Doc, :id => 'mock')
      @search = mock_model(Search, :perform => [@doc])
    end

    context "a new list" do
      before do
        @list.search = @search
      end
      it "should try to populate itself" do
        @list.should_receive(:populate!)
        @list.save!
      end
      it "should ask the search to perform itself" do
        @search.should_receive(:perform)
        @list.save!
      end
      it "should populate itself from the results retrieved from the search" do
        @list.save!
        @list.docs.should == [@doc]
      end
    end

    context "an existing list" do
      before do
        @list.save!
        @list.search = @search
      end
      it "should ask the search to perform itself" do
        @search.should_receive(:perform)
        @list.save!
      end
      it "should populate its docs from the search" do
        @list.save!
        @list.docs.should == [@doc]
      end
    end
  end

  context "with no search assigned" do
    context "a new list" do
      it "should not try to populate itself" do
        @list.should_not_receive(:populate!)
        @list.save!
      end
    end

    context "an existing list" do
      before do
        @list.save!
      end
      it "should not try to populate itself" do
        @list.should_not_receive(:populate!)
        @list.save!
      end
    end
  end

  context "with the same search as last save" do
    before do
      @search = mock_model(Search, :perform => [])
      @list.search = @search
      @list.save!
    end
    it "should not try to populate itself" do
      @list.should_not_receive(:populate!)
      @list.save!
    end
  end
end