require 'spec_helper'

describe Section do

  it 'is valid with valid attributes' do
    Section.new(:name => 'Foo').should be_valid
  end

  describe '#title' do

    it 'returns the name' do
      Section.new(:name => 'Foo').title.should == 'Foo'
    end
  end
end
