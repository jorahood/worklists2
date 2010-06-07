require 'spec_helper'

describe IndexItem do
  it "should have a table named 'indexitem'" do
    IndexItem.table_name.should == 'indexitem'
  end
  it "should not be auto-imported from bell" do
    IndexItem.import_from_bell.should be_false
  end
  it "should be a subclass of Kb3 abstract model" do
    IndexItem.superclass.should == Kb3
  end
  it {should belong_to :doc}
end
