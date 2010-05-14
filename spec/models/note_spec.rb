require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Note do
  before(:each) do
    @user = mock_model(Kbuser,:username=>'Fred',:administrator? => false, :signed_up? => true)
    @valid_attributes = {
      :text => "This is a note.",
      :creator => @user
    }
  end

  subject {Note.create!(@valid_attributes)}
  it { should respond_to :list }
  it { should belong_to :listed_doc }
  it { should belong_to :doc }
  it { should belong_to :creator }

#  it "should create a new instance given valid attributes" do
#    Note.create!(@valid_attributes)
#  end
#
#  it "should have a text field" do
#    subject.should respond_to(:text)
#  end
#
#  it "should have a title field" do
#    subject.should respond_to(:title)
#  end
#
#  describe "associations:" do
#    it "should belong to a list_item" do
#      subject.should belong_to(:list_item)
#    end
#
#    it "should have user=creator" do
#      pending "durrrrrr?"
#    end

#  end

  describe "Permissions" do

    before(:each) do
      @admin = mock_model(Kbuser, :administrator? => true, :signed_up? => true)
      @other_user = mock_model(Kbuser,:username=>'George',:administrator? => false, :signed_up? => true)
      @guest = mock_model(Guest, :signed_up? => false)
      @updated_note_w_new_user = Note.new(:creator=>@other_user)
    end
    it "should not allow users to change the creator assoc" do
      subject.should_not be_editable_by(@user, :creator)
    end
    it "should not allow users to change the doc assoc" do
      subject.should_not be_editable_by(@user, :doc)
    end
    it "should not allow users to change the listed_doc assoc" do
      subject.should_not be_editable_by(@user, :listed_doc)
    end
    it {should be_destroyable_by @user}
    it {should_not be_destroyable_by @other_user}

  end
end
