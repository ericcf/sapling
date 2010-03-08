$:.unshift File.join(File.dirname(__FILE__), '..')
require 'spec_helper.rb'

describe WorkflowState do

  # database constraints

  it 'enforces name uniqeness at the physical layer' do
    WorkflowState.create!(:name => 'Foo')
    duplicate = WorkflowState.new(:name => 'Foo')
    lambda {
      duplicate.save(false)
    }.should raise_error(ActiveRecord::StatementInvalid)
  end

  # validation

  it 'is valid with valid attributes' do
    WorkflowState.new(:name => 'Foo').should be_valid
  end

  it 'is not valid without a name' do
    WorkflowState.new(:name => nil).should_not be_valid
  end

  it 'is not valid with a duplicate name' do
    WorkflowState.create!(:name => 'Foo')
    WorkflowState.new(:name => 'Foo').should_not be_valid
  end
end
