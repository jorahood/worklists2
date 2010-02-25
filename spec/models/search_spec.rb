require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Search do
  it { should have_many :lists }
  it {should have_many :docid_searches}
  it {should have_many(:docids).through(:docid_searches)}
  it {should have_many :resource_searches}
  it {should have_many(:resources).through(:resource_searches)}

  it { should validate_presence_of :name }

  it "should invoke Doc#docid_search named scope when docids are given" do
    doc = mock_model(Doc, :id => 'aaaa')
    subject.docids << doc
    Doc.should_receive(:docid_search).with(doc)
    subject.filter
  end

  it "should invoke Doc#with_any_resources scope when resources are given" do
    user1 = mock_model(Kbuser)
    user2 = mock_model(Kbuser)
    subject.resources << user1
    subject.resources << user2
    Doc.should_receive(:any_of_resources).with(user1, user2)
    subject.filter
  end

  it "should create a list of the results" do
    List.should_receive(:new)
    subject.save_as_list
  end
end
