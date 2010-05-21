require 'spec_helper'

describe Kb3Event do
  it "should import from bell" do
    Kb3Event.import_from_bell.should be_true
  end
  it "s table is named 'event'" do
    Kb3Event.table_name.should == "event"
  end
it { should belong_to :doc }
it { should belong_to :kbuser }
end
