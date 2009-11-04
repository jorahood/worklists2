require File.dirname(__FILE__) + '/../test_helper'

class ListsControllerTest < ActionController::TestCase
  # Replace this with your real tests.

  it "should pass a search by docid to Doc#docid_search named_scope" do
    search_params =
    Doc.should_receive(:docid_search).with()
  end
end
