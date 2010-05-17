require 'spec_helper'

describe WorkshopWfinode do
  it "should import from bell" do
    WorkshopWfinode.import_from_bell.should be_true
  end
  it "s table is named 'wfinode'" do
    WorkshopWfinode.table_name.should == "wfinode"
  end

end
