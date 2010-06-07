require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DocsController do

  it "should have an autocomplete route for id" do
    get :complete_id
  end

  context "handling GET doc.xml" do

    before do
      @doc = Factory.create(:doc)
      Doc.stub!(:find).and_return(@doc)
    end

    it "should return xml content" do
      get :show, { :id => @doc.id, :format => 'xml' }
      response.content_type.should == "application/xml"
    end

    it "should retrieve kbxml and render it" do
      test_kbxml = File.read("#{RAILS_ROOT}/spec/fixtures/aazf.xml")
      @doc.should_receive(:kbxml).and_return(test_kbxml)
      get :show, { :id => @doc.id, :format => 'xml' }
      response.body.should match(/kbml/)
    end
  end
end
