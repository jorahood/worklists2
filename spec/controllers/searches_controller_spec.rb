require 'spec_helper'

describe SearchesController do
  context "handling GET search.xml" do

    before do
      @search = Search.create!(:name => 'blah')
    end

    it "should try to retrieve the xml for the search" do
      get :show, { :id => @search.id, :format => 'xml' }
      response.content_type.should == "application/xml"
    end
  end
end
