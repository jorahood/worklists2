require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Doc do
  before(:each) do
    @valid_attributes = {
    }
    @doc = Doc.new(@valid_attributes)
  end

  it "should create a new instance given valid attributes" do
    Doc.create!(@valid_attributes)
  end

  it "should have a docid attribute" do
    @doc.should respond_to(:docid)
  end

  
  describe "associations:" do

    it "should have many titles" do
    @doc.should have_many(:titles)
  end

    it "should have many list_items" do
      @doc.should have_many(:listed_docs)
    end

    it "should have many lists through list items" do
      @doc.should have_many(:lists)
    end
    
  end


  describe "permissions:" do

  end
end