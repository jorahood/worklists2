require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Kbuser do

  it { should have_many :lists }
  it { should have_many :notes }

  it "should have the lists and notes as creator rather than user" do
    assoc = Kbuser.reflect_on_all_associations(:has_many).find_all { |a| a.name == :lists || a.name == :notes }
    assoc.*.primary_key_name.should == ["creator_id","creator_id"]
  end

  #    it "should have many notes" do
  #      @user.should have_many(:notes)
  #    end
end
