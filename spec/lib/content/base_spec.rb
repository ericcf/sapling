require File.dirname(__FILE__) + '/../../spec_helper.rb'

describe Content::Base do

  before(:each) do
    class MockContent; end
    class MockContent
      include Content::Base
    end
  end
end