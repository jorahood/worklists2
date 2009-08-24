require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe List do
  before(:each) do
    @user = mock_model(User, :admin? => false, :signed_up? => true)
    @list = List.new(:name=>'test', :owner=>@user)
  end

#  it "should be valid" do
#    @list.should be_valid
#  end
#
#  it "should have a name" do
#    @list.should respond_to(:name)
#  end
#
#  it "should have an owner" do
#    @list.should respond_to(:owner)
#  end
#
#  it "should have a comment" do
#    @list.should respond_to(:comment)
#  end
#
#  describe "validations:" do
#    it "should validate presence of name" do
#      @list.should validate_presence_of(:name)
#    end
#
#    it "should validate presence of owner" do
#      @list.should validate_presence_of(:owner)
#    end
#  end
#
#
#  describe "associations:" do
#    it "should belong to an owner" do
#      @list.should belong_to(:owner)
#    end
#
#    it "should have the owner be a User object" do
#      pending "don't know how to spec this"
#    end
#
#    it "should name the owner as creator" do
#      pending "how do I spec this?"
#    end
#
#    it "should have many list items" do
#      @list.should have_many(:list_items)
#    end
#
#    it "should have many docs through list_items" do
#      @list.should have_many(:docs)
#    end
#  end
#
#
#  describe "permissions:" do
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
#  end
end