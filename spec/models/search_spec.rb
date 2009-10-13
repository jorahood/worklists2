require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Search do

  subject { Search.new }

  context "Associations" do
    it {should have_many(:search_to_list_assignments)}
    it { should have_many(:lists).through(:search_to_list_assignments) }
  end

  context "Validations" do
    it { should validate_presence_of(:name) }
  end

  it "should create a list of the results" do
    List.should_receive(:new)
    subject.save_as_list
  end

  specify { }
end
