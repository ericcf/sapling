require 'spec_helper'

describe WorkflowHelper do

  describe '#workflow_states' do

    it 'returns an Array of WorkflowState names' do
      WorkflowState.stub!(:all).
        and_return([mock_model(WorkflowState, :name => 'Foo')])
      states = helper.workflow_states
      states.size.should == 1
      states.first.should == 'Foo'
    end
  end
end