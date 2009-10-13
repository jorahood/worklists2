require 'spec_helper'

describe SearchToListAssignment do
  before do
  end

  it { should belong_to :search }
  it { should belong_to :list }
end
