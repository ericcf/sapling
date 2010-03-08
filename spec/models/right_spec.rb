$:.unshift File.join(File.dirname(__FILE__), '..')
require 'spec_helper.rb'

describe Right do

  it 'is valid with valid attributes' do
    Right.new(:name => 'Foo',
      :controller => 'Bar',
      :action => 'Baz').should be_valid
  end

  it 'is not valid without a name' do
    Right.new(:name => nil,
      :controller => 'Bar',
      :action => 'Baz').should_not be_valid
  end

  it 'is not valid without a controller' do
    Right.new(:name => 'Foo',
      :controller => nil,
      :action => 'Baz').should_not be_valid
  end

  it 'is not valid without an action' do
    Right.new(:name => 'Foo',
      :controller => 'Bar',
      :action => nil).should_not be_valid
  end

  it 'is not valid with a duplicate controller and action' do
    Right.create!(:name => 'Foo',
      :controller => 'Bar',
      :action => 'Baz')
    Right.new(:name => 'Foof',
      :controller => 'Bar',
      :action => 'Baz').should_not be_valid
  end
end
