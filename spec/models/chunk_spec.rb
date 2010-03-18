$:.unshift File.join(File.dirname(__FILE__), '..')
require 'spec_helper.rb'

describe Chunk do

  it 'is valid with valid attributes' do
    section = mock_model(Section, :valid? => true)
    Chunk.new(:name => 'Foo',
      :section => section,
      :text => 'Bar').should be_valid
  end

  describe '#title' do

    it 'returns the name' do
      chunk = Chunk.new(:name => 'Foo')
      chunk.title.should == 'Foo'
    end
  end
end
