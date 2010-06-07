require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Doc do

  subject {Factory.create(:doc)}
  # Attributes
  it { should respond_to :docid }
  it "should have a named scope called docid_search" do
    Doc.should respond_to :docid_search
  end
  it "should have a named scope called text_search" do
    Doc.should respond_to :text_search
  end

  # Associations
  it { should have_many :titles }
  it { should have_many :listed_docs }
  it { should have_many(:lists).through(:listed_docs) }
  it { should have_many :docid_searches }
  it { should have_many(:searches).through(:docid_searches) }
  it { should have_many :workshop_document_assets }
  it { should have_many(:workshop_wfinodes).through :workshop_document_assets }
  it { should have_many :index_items }

  # Validations
  it {should validate_presence_of :id}
  it {should validate_uniqueness_of :id}

  # Searching

  context "Searching" do

    before do
      @doc1 = Factory.create(:doc)
      @doc2 = Factory.create(:doc)
    end

    specify "by docids" do
      Doc.docid_search(@doc1.id,@doc2.id).find(:all).should == [@doc1,@doc2]
    end

    specify "by text, sorted by score" do
      Factory.create(:index_item, :docid => @doc1.id, :word => 'hippo', :score => 1.0000)
      Factory.create(:index_item, :docid => @doc2.id, :word => 'hippo', :score => 2.0000)
      Doc.text_search('hippo').find(:all).should == [@doc2,@doc1]
    end
  end

  it "should have a method for each of ListedDoc's delegated accessors" do
    ListedDoc.delegated_accessors.each do |method|
      lambda {subject.send(method)}.should_not raise_error(NoMethodError)
    end
  end

end