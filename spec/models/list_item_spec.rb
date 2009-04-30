require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ListItem do
  before(:each) do
    @list_item = ListItem.new
  end

  it "should be valid" do
    @list_item.should be_valid
  end


  describe "validations:" do
    it "should validate existence of list"
    it "should validate existence of doc"

  end
  describe "associations:" do
    it "should belong to a doc" do
      @list_item.should belong_to(:doc)
    end

    it "should belong to a list" do
      @list_item.should belong_to(:list)
    end

    it "should have many notes" do
      @list_item.should have_many(:notes)
    end

  end
  
  
  describe "permissions:" do
    before do
      @admin = stub('User', :username=>'Admin', :signed_up? => true, :admin? => true)
      @user = stub('User', :username=>'Chuck', :signed_up? => true, :admin? => false)
      @other_user = stub('User', :username=>'Bob', :signed_up? => true, :admin? => false)
      @list = mock_model(List, :name=>'test', :owner=>@user)
      @doc = mock_model(Doc, :docid=>'blah', :title=>'blahblah')
      @list_item.list = @list
    end

    it "should be creatable by list owner" do
      @list_item.creatable_by?(@user).should be_true
    end
    
    it "should not be creatable by non-admin list non-owner" do
      @list_item.creatable_by?(@other_user).should be_false
    end

    it "should be creatable by admin" do
      @list_item.creatable_by?(@admin).should be_true
    end

    it "should be updatable by list owner" do
      @list_item.updatable_by?(@user,@list_item).should be_true
    end

    
    describe "updating notes:" do
      before do
        @list_item.doc = @doc
        @note = mock_model(Note)
        @list_item_w_note = ListItem.new(:list=>@list,:doc=>@doc, :notes=>[@note])
      end

      it "should allow adding notes" do
        @list_item.updatable_by?(@user,@list_item_w_note).should be_true
      end
      
      it "should not allow non-admins to remove notes" do
        @list_item_w_note.updatable_by?(@user,@list_item).should be_false
      end

      it "should allow admins to remove notes" do
        @list_item_w_note.updatable_by?(@admin,@list_item).should be_true
      end
    end

    # Since the list_item is just a join model, it shouldn't let users change its associations
    it "should not allow non-admin to update list" do
      @list_item.updatable_by?(@user,ListItem.new(:doc=>@doc, :list=>mock_model(List))).should be_false
    end

    it "should not allow non-admin to update doc" do
      @list_item.updatable_by?(@user,ListItem.new(:list=>@list, :doc=>mock_model(Doc))).should be_false
    end

    it "should allow admin to update list" do
      @list_item.updatable_by?(@admin,ListItem.new(:doc=>@doc, :list=>mock_model(List))).should be_true
    end

    it "should allow admin to update doc" do
      @list_item.updatable_by?(@admin,ListItem.new(:list=>@list, :doc=>mock_model(Doc))).should be_true      
    end

    it "should allow owner to delete" do
      @list_item.deletable_by?(@user).should be_true
    end

  end
end
