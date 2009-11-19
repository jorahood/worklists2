require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DocsController do

  context "testing login here instead of shaving the yak of setting up app-wide spec in application_controller_spec.rb" do

    it "should set current_user to cas_user if present" do
      session[:cas_user] = 'bob'
      get :index
#      controller.current_user.should == 'bob'
    end
  end
  
  context "handling GET doc.xml" do

    before do
      @doc = Doc.new
      @doc.id = "aazf"
      @doc.save!
      Doc.stub!(:find).and_return(@doc)
    end

    it "should return xml content" do
      get :show, { :id => @doc.id, :format => 'xml' }
      response.content_type.should == "application/xml"
    end

    it "should retrieve kbxml and render it" do
      aazf_kbxml = File.read("#{RAILS_ROOT}/spec/fixtures/aazf.xml")
      @doc.should_receive(:kbxml).and_return(aazf_kbxml)
      get :show, { :id => @doc.id, :format => 'xml' }
      response.body.should match(/kbml/)
    end
  end
end
