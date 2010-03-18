require 'spec_helper'

describe ContentWorkflowState do

  describe '#apply_triggers!' do

    it 'calls activate_if_ready! on all workflow_triggers' do
      trigger = mock_model(WorkflowTrigger)
      cws = ContentWorkflowState.new
      cws.stub!(:workflow_triggers).and_return([trigger])
      trigger.should_receive(:activate_if_ready!)
      cws.apply_triggers!
    end
  end
end