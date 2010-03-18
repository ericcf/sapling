require 'spec_helper.rb'
require 'mock_model'

describe Content::Stateful do

  before(:each) do
    class StatefulFoo < MockModel
      include Content::Stateful
    end

    @foo = StatefulFoo.new
  end

  describe '#set_workflow_state' do

    context 'there is a default WorkflowState' do

      it 'creates an associated ContentWorkflowState' do
        workflow_state = mock_model(WorkflowState)
        WorkflowState.stub!(:default).and_return(workflow_state)
        @foo.should_receive(:create_content_workflow_state).
          with(:workflow_state => workflow_state)
        @foo.set_workflow_state
      end
    end
  end

  describe '#workflow_state' do

    it 'returns the state via the content_workflow_state association' do
      workflow_state = mock_model(WorkflowState)
      cwf = mock_model(ContentWorkflowState, :workflow_state => workflow_state)
      @foo.stub!(:content_workflow_state).and_return(cwf)
      @foo.workflow_state.should == workflow_state
    end
  end

  describe '#workflow_state=(:new_state)' do

    it 'updates the workflow_state attribute of the content_workflow_state' do
      cwf = mock_model(ContentWorkflowState)
      @foo.stub!(:content_workflow_state).and_return(cwf)
      state = mock_model(WorkflowState)
      cwf.should_receive(:update_attributes).with(:workflow_state => state)
      @foo.workflow_state = state
    end
  end

  describe '#apply_workflow_triggers!' do

    it 'calls apply_triggers! on the content_workflow_state' do
      cwf = mock_model(ContentWorkflowState)
      @foo.stub!(:content_workflow_state).and_return(cwf)
      cwf.should_receive(:apply_triggers!)
      @foo.apply_workflow_triggers!
    end
  end
end
