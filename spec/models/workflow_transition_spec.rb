require 'spec_helper.rb'

describe WorkflowTransition do

  it 'is valid with valid attributes' do
    before = mock_model(WorkflowState, :valid? => true)
    after = mock_model(WorkflowState, :valid? => true)
    transition = WorkflowTransition.new(:before_state => before,
      :after_state => after, :name => 'foo').should be_valid
  end

  it 'is not valid without a name' do
    before = mock_model(WorkflowState, :valid? => true)
    after = mock_model(WorkflowState, :valid? => true)
    transition = WorkflowTransition.new(:before_state => before,
      :after_state => after, :name => nil).should_not be_valid
  end

  it 'is not valid with invalid before_state' do
    before = mock_model(WorkflowState, :valid? => false)
    after = mock_model(WorkflowState, :valid? => true)
    transition = WorkflowTransition.new(:before_state => before,
      :after_state => after, :name => 'foo').should_not be_valid
  end

  it 'is not valid with invalid after_state' do
    before = mock_model(WorkflowState, :valid? => true)
    after = mock_model(WorkflowState, :valid? => false)
    transition = WorkflowTransition.new(:before_state => before,
      :after_state => after, :name => 'foo').should_not be_valid
  end
end
