require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Search do

  subject { Search.new }

  describe "Validations" do
    it { should validate_presence_of(:name) }
  end

  it "should create a new instance given valid attributes" do
    Search.create!(:name => 'bubba')
  end

end
