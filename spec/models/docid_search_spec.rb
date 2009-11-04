require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DocidSearch do
  context "Associations" do
    it { should belong_to :search }
    it { should belong_to :doc }
  end
end
