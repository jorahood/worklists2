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

  specify "search by docid should return matches for given list of docids" do
    aaaa = Doc.new
    aaaa.id = 'aaaa'
    aaaa.save!
    bbbb = Doc.new
    bbbb.id = 'bbbb'
    bbbb.save!
    Doc.docid_search('aaaa','bbbb').find(:all).should == [aaaa,bbbb]
  end

  it "should have a method for each of ListedDoc's delegated accessors" do
    ListedDoc.delegated_accessors.each do |method|
      lambda {subject.send(method)}.should_not raise_error(NoMethodError)
    end
  end

end