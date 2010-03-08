$:.unshift File.join(File.dirname(__FILE__), '..')
require 'spec_helper.rb'

describe Tag do

  it 'is valid with valid attributes' do
    Tag.new(:label => 'Foo').should be_valid
  end

  it 'is not valid without a label' do
    Tag.new(:label => nil).should_not be_valid
  end
end
