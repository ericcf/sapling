$:.unshift File.join(File.dirname(__FILE__), '..')
require 'spec_helper.rb'

describe StatefulRight do

  before(:each) do
    @right = mock_model(Right, :destroyed? => false).as_null_object
    @role = mock_model(Role, :destroyed? => false).as_null_object
    @workflow_state = mock_model(WorkflowState, :destroyed? => false).as_null_object
  end

  # database constraints

  it 'enforces attribute uniqeness at the physical layer' do
    StatefulRight.create!(:right => @right,
      :role => @role,
      :workflow_state => @workflow_state)
    duplicate = StatefulRight.new(:right => @right,
      :role => @role,
      :workflow_state => @workflow_state)
    lambda {
      duplicate.save(false)
    }.should raise_error(ActiveRecord::StatementInvalid)
  end

  # validation

  it 'is valid with valid attributes' do
    StatefulRight.new(:right => @right,
      :role => @role,
      :workflow_state => @workflow_state).should be_valid
  end

  it 'is not valid with duplicate attributes' do
    StatefulRight.create!(:right => @right,
      :role => @role,
      :workflow_state => @workflow_state)
    StatefulRight.new(:right => @right,
      :role => @role,
      :workflow_state => @workflow_state).should_not be_valid
  end
end
