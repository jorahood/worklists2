require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @valid_attributes = {
      :name => 'Bob'
    }
    @user = User.new(@valid_attributes)
  end

  describe "associations:" do
    it { should have_many(:lists) }

    it "should have the lists as owner rather than user" do
      assoc = User.reflect_on_all_associations(:has_many).find { |a| a.name == :lists }
      assoc.primary_key_name.should == "owner_id"
    end

#    it "should have many notes" do
#      @user.should have_many(:notes)
#    end
  end
end
