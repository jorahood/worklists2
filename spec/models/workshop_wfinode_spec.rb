require 'spec_helper'

describe WorkshopWfinode do
  it "should import from bell" do
    WorkshopWfinode.import_from_bell.should be_true
  end
  it "s table is named 'wfinode'" do
    WorkshopWfinode.table_name.should == "wfinode"
  end
it { should have_many :workshop_document_assets }
it { should have_many(:docs).through :workshop_document_assets }
end
