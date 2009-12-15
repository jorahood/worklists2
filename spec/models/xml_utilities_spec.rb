require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe XmlUtilities do

  specify "fetch_url should throw an exception if it can't reach a site with fetch_url" do
    url = 'http://bogus.uits.indiana.edu'
    lambda {
      XmlUtilities.fetch_url(url)
    }.should raise_error SocketError
  end

  specify "fetch_url should throw an error for HTTP client exceptions" do
    url = 'https://kbhandbook.indiana.edu/brparhdfhhfhffffff'
    lambda {
      XmlUtilities.fetch_url(url)
    }.should raise_error Net::HTTPServerException, /404/
  end

  context "cloning all v1 lists" do
    before do
      @list_ids_string = "1\n2\n3\n"
      @list_ids_array = ["1","2","3"]
      @list = Factory.build(:list,:wl1_clone => '1', :name=> 'bogus')
      @list2 = Factory.build(:list,:wl1_clone => '2', :name => 'bogus')
      @list3 = Factory.build(:list,:wl1_clone => '3', :name => 'bogus')
      List.stub(:new).with(:wl1_clone=>'1').and_return(@list)
      List.stub(:new).with(:wl1_clone=>'2').and_return(@list2)
      List.stub(:new).with(:wl1_clone=>'3').and_return(@list3)
    end
    it "should try to get all v1 worklist ids" do
      List.stub(:save!).and_return(true)
      XmlUtilities.should_receive(:get_all_list_ids).and_return([])
      XmlUtilities.clone_all_v1_lists
    end
    it "should get all v1 worklist ids" do
      XmlUtilities.should_receive(:fetch_url).with("#{XmlUtilities::WL1ListIndex}").and_return(@list_ids_string)
      @lists = XmlUtilities.get_all_list_ids
    end
    it "should have a url it actually gets the list ids from" do
      XmlUtilities.fetch_url("#{XmlUtilities::WL1ListIndex}").should match(/(^\d+\n$)+/)
    end
    it "should return the list ids as an array" do
      XmlUtilities.stub(:get_all_list_ids).and_return(@list_ids_array)
      @lists = XmlUtilities.get_all_list_ids
      @lists.should == @list_ids_array
    end
    it "should create new lists and set #wl1_clone for each v1 list id it retrieves" do
      XmlUtilities.stub(:fetch_url).and_return(@list_ids_string)
      List.should_receive(:new).with(:wl1_clone=>'1').and_return(@list)
      List.should_receive(:new).with(:wl1_clone=>'2').and_return(@list2)
      List.should_receive(:new).with(:wl1_clone=>'3').and_return(@list3)
      XmlUtilities.clone_all_v1_lists
    end
    it "should save each new list to trigger do_clone" do
      XmlUtilities.stub(:fetch_url).and_return(@list_ids_string)
      @list.should_receive(:save!)
      @list2.should_receive(:save!)
      @list3.should_receive(:save!)
      XmlUtilities.clone_all_v1_lists
    end
  end
end