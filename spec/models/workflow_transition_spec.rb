require 'spec_helper.rb'

describe WorkflowTransition do

  def mock_state(valid)
    mock_model(WorkflowState, :valid? => valid)
  end

  it 'is valid with valid attributes' do
    before, after = mock_state(true), mock_state(true)
    WorkflowTransition.new(:before_state => before,
      :after_state => after, :name => 'foo').should be_valid
  end

  it 'is not valid without a name' do
    before, after = mock_state(true), mock_state(true)
    WorkflowTransition.new(:before_state => before,
      :after_state => after, :name => nil).should_not be_valid
  end

  it 'is not valid without a before_state' do
    before, after = nil, mock_state(true)
    WorkflowTransition.new(:before_state => before,
      :after_state => after, :name => nil).should_not be_valid
  end

  it 'is not valid with invalid before_state' do
    before, after = mock_state(false), mock_state(true)
    WorkflowTransition.new(:before_state => before,
      :after_state => after, :name => 'foo').should_not be_valid
  end

  it 'is not valid without an after_state' do
    before, after = mock_state(true), nil
    WorkflowTransition.new(:before_state => before,
      :after_state => after, :name => nil).should_not be_valid
  end

  it 'is not valid with invalid after_state' do
    before, after = mock_state(true), mock_state(false)
    WorkflowTransition.new(:before_state => before,
      :after_state => after, :name => 'foo').should_not be_valid
  end

  context 'is destroyed' do

    it 'destroys its triggers' do
      before, after = mock_state(true), mock_state(true)
      transition = WorkflowTransition.create!(:before_state => before,
        :after_state => after, :name => 'foo')
      trigger = mock_model(WorkflowTrigger, :workflow_transition => transition)
      WorkflowTrigger.stub!(:find).with(:all, anything).and_return([trigger])
      trigger.should_receive(:destroy)
      transition.destroy
    end
  end
end
