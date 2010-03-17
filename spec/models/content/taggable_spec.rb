require 'spec_helper.rb'
require 'mock_model'

describe Content::Taggable do

  before(:each) do
    class TaggableFoo < MockModel
      include Content::Taggable
    end
  end
end