require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Kbuser do

  it "should let you check if a user is an editor" do
    pending "need to import UserTypes" do
      should respond_to :is_kbeditor?
    end
  end
  it { should have_many :lists }
  it { should have_many :notes }
  it { should have_many :workshop_wfinodes }
  it { should have_many(:workshop_document_assets).through :workshop_wfinodes }
  it "should have the lists and notes as creator rather than user" do
    assoc = Kbuser.reflect_on_all_associations(:has_many).find_all { |a| a.name == :lists || a.name == :notes }
    assoc.*.primary_key_name.should == ["creator_id", "creator_id"]
  end

  #    it "should have many notes" do
  #      @user.should have_many(:notes)
  #    end
end
