require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Doc do

  it { should respond_to :docid }
  
  it { should have_many :titles }
  it { should have_many :listed_docs }
  it { should have_many(:lists).through(:listed_docs) }
  it { should have_many :docid_searches }
  it { should have_many(:searches).through(:docid_searches) }

  it "should have a named scope called docid_search" do
    Doc.should respond_to :docid_search
  end

  specify "docid search should return matches for given array of docids" do
    aaaa = Doc.new
    aaaa.id = 'aaaa'
    aaaa.save!
    Doc.docid_search(['aaaa']).find(:all).should == [aaaa]
  end
end