require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Doc do

  it { should respond_to :docid }
  
  describe "associations:" do

    it { should have_many :titles }
    it { should have_many :listed_docs }
    it { should have_many(:lists).through(:listed_docs) }
    it { should have_many :docid_searches }
    it { should have_many(:searches).through(:docid_searches) }
  end

  describe "permissions:" do

  end
end