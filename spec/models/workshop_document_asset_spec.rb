require 'spec_helper'

describe WorkshopDocumentAsset do

  it "should import from bell" do
    WorkshopDocumentAsset.import_from_bell.should be_true
  end
  it "table is named documentasset" do
    WorkshopDocumentAsset.table_name.should == "documentasset"
  end
  it { should belong_to :doc }
  it { should belong_to :workshop_wfinode }
end
