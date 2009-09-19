require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe List do
  before(:each) do
    @user = mock_model(User, :admin? => false, :signed_up? => true)
    @list = List.new(:name=>'test', :owner=>@user)
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

  describe "validations:" do

    specify { @list.should validate_presence_of(:name) }

    specify { @list.should validate_presence_of(:owner) }
  end


  describe "associations:" do
    specify { @list.should belong_to(:owner)}

    specify { @list.should have_many(:listed_docs)}

    it "should have many docs through listed_docs" do
      @list.should have_many(:docs)
    end
  end


  describe "permissions:" do
#    before(:each) do
#      @admin = mock_model(User, :admin? => true, :signed_up? => true)
#      @other_user = mock_model(User,:admin? => false, :signed_up? => true)
#      @guest = mock_model(Guest, :signed_up? => false)
#      @updated_list_w_new_owner = List.new(:name=>'test', :owner=>@other_user)
#    end
#
#    it "should be creatable by owner" do
#      @list.creatable_by?(@user).should be_true
#    end
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
end