require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Note do
  before(:each) do
    @user = mock_model(User,:username=>'Fred',:admin? => false, :signed_up? => true)
    @valid_attributes = {
      :text => "This is a note.",
      :user => @user
    }
    @note = Note.new(@valid_attributes)
  end

  it "should create a new instance given valid attributes" do
    Note.create!(@valid_attributes)
  end

  it "should have a text field" do
    @note.should respond_to(:text)
  end

  it "should have a title field" do
    @note.should respond_to(:title)
  end
  
  describe "associations:" do
    it "should belong to a list_item" do
      @note.should belong_to(:list_item)
    end

    it "should belong to a user" do
      @note.should belong_to(:user)
    end

    it "should have user=creator" do
      pending "durrrrrr?"
    end

  end

  describe "permissions:" do

    before(:each) do
      @admin = mock_model(User, :admin? => true, :signed_up? => true)
      @other_user = mock_model(User,:username=>'George',:admin? => false, :signed_up? => true)
      @guest = mock_model(Guest, :signed_up? => false)
      @updated_note_w_new_user = Note.new(:user=>@other_user)
    end

    it "should be creatable by signed-up user" do
      @note.creatable_by?(@user).should be_true
    end

    it "should be tied to a user as creator" do
      # this helps hobo know that the current user can create their own projects
      # only, and the Owner field shouldn't be displayed on the new list form
      @note.creatable_by?(@other_user).should be_false
    end

    it "should not be updatable by non-admin"
  end
end
