require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DocsController do

  context "handling GET /doc.xml" do

    before do
      @doc = Doc.new
      @doc.id = "abcd"
      @doc.save!
    end

    it "should try to retrieve the xml for the doc" do
      get :show, { :id => @doc.id, :format => 'xml' }
      response.content_type.should == "application/xml"
    end
  end
end
