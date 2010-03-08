$:.unshift File.join(File.dirname(__FILE__), '..')
require 'spec_helper.rb'

describe Group do

  # database constraints

  it 'enforces name uniqeness at the physical layer' do
    Group.create!(:name => 'Foo')
    duplicate = Group.new(:name => 'Foo')
    lambda {
      duplicate.save(false)
    }.should raise_error(ActiveRecord::StatementInvalid)
  end

  # validation

  it 'is valid with valid attributes' do
    Group.new(:name => 'Foo').should be_valid
  end

  it 'is not valid without a name' do
    Group.new(:name => nil).should_not be_valid
  end

  it 'is not valid with a duplicate name' do
    Group.create!(:name => 'Foo')
    Group.new(:name => 'Foo').should_not be_valid
  end
end
