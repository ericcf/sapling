$:.unshift File.join(File.dirname(__FILE__), '..')
require 'spec_helper.rb'
require 'mock_model'

describe RoleAssignment do

  before(:each) do
    @role = mock_model(Role, :destroyed? => false).as_null_object
    @entity = mock_model(MockModel, :destroyed? => false).as_null_object
  end

  # database constraints

  it 'enforces attribute uniqeness at the physical layer' do
    RoleAssignment.create!(:role => @role,
      :entity => @entity)
    duplicate = RoleAssignment.new(:role => @role,
      :entity => @entity)
    lambda {
      duplicate.save(false)
    }.should raise_error(ActiveRecord::StatementInvalid)
  end

  # validation

  it 'is valid with valid attributes' do
    RoleAssignment.new(:role => @role,
      :entity => @entity).should be_valid
  end

  it 'is not valid with duplicate attributes' do
    RoleAssignment.create!(:role => @role,
      :entity => @entity)
    RoleAssignment.new(:role => @role,
      :entity => @entity).should_not be_valid
  end
end
