require 'spec_helper'

describe IndexItem do
  it "should have a table named 'indexitem'" do
    IndexItem.table_name.should == 'indexitem'
  end
  it "should import from bell" do
    IndexItem.import_from_bell.should be_true
  end
  it {should belong_to :doc}
end
