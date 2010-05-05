require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Note do
  before(:each) do
    @user = mock_model(Kbuser,:username=>'Fred',:administrator? => false, :signed_up? => true)
    @valid_attributes = {
      :text => "This is a note.",
      :creator => @user
    }
    @note = Note.create!(@valid_attributes)
  end

  it { should belong_to :listed_doc }
  it { should belong_to :doc }
  it { should belong_to :creator }

#  it "should create a new instance given valid attributes" do
#    Note.create!(@valid_attributes)
#  end
#
#  it "should have a text field" do
#    @note.should respond_to(:text)
#  end
#
#  it "should have a title field" do
#    @note.should respond_to(:title)
#  end
#
#  describe "associations:" do
#    it "should belong to a list_item" do
#      @note.should belong_to(:list_item)
#    end
#
#    it "should have user=creator" do
#      pending "durrrrrr?"
#    end

#  end

  describe "permissions:" do

    before(:each) do
      @admin = mock_model(Kbuser, :administrator? => true, :signed_up? => true)
      @other_user = mock_model(Kbuser,:username=>'George',:administrator? => false, :signed_up? => true)
      @guest = mock_model(Guest, :signed_up? => false)
      @updated_note_w_new_user = Note.new(:creator=>@other_user)
    end
    it "should be destroyable by its creator" do
      @note.should be_destroyable_by @user
    end
    it "should not be destroyable by other users" do
      @note.should_not be_destroyable_by @other_user
    end
  end
end
