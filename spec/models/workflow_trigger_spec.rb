require 'spec_helper.rb'
require 'mock_model'

describe WorkflowTrigger do

  before(:each) do
    @valid_cws = mock_model(ContentWorkflowState, :valid? => true)
    @valid_state = mock_model(WorkflowState, :valid? => true)
  end

  it 'is valid with valid attributes' do
    WorkflowTrigger.new(:content_workflow_state => @valid_cws,
                        :target_state => @valid_state).should be_valid
  end

  it 'is not valid without a content_workflow_state' do
    WorkflowTrigger.new(:content_workflow_state => nil,
                        :target_state => @valid_state).should_not be_valid
  end

  it 'is not valid without a valid content_workflow_state' do
    cws = mock_model(ContentWorkflowState, :valid? => false)
    WorkflowTrigger.new(:content_workflow_state => cws,
                        :target_state => @valid_state).should_not be_valid
  end

  it 'is not valid without a target_state' do
    WorkflowTrigger.new(:content_workflow_state => @valid_cws,
                        :target_state => nil).should_not be_valid
  end

  it 'is not valid without a valid target_state' do
    state = mock_model(WorkflowState, :valid? => false)
    WorkflowTrigger.new(:content_workflow_state => @valid_cws,
                        :target_state => state).should_not be_valid
  end

  describe '#transition_content' do

    before(:each) do
      @mock_target_state = mock_model(WorkflowState)
    end

    it 'destroys self' do
      content_state = mock_model(ContentWorkflowState,
                                 :workflow_state => @mock_target_state,
                                 :content => mock_model(MockModel)
      )
      trigger = WorkflowTrigger.new(:content_workflow_state => content_state,
                                    :target_state => @mock_target_state)
      trigger.should_receive(:destroy)
      trigger.transition_content
    end

    context 'content is in target state' do

      it 'does not change content state' do
        content_state = mock_model(ContentWorkflowState,
                                   :workflow_state => @mock_target_state,
                                   :content => mock_model(MockModel)
        )
        trigger = WorkflowTrigger.new(:content_workflow_state => content_state,
                                      :target_state => @mock_target_state)
        content_state.should_not_receive(:update_attributes)
        trigger.transition_content
      end
    end

    context 'content is not in target state' do

      it 'changes content state to target state' do
        content_state = mock_model(ContentWorkflowState,
                                   :workflow_state => mock_model(WorkflowState),
                                   :content => mock_model(MockModel)
        )
        trigger = WorkflowTrigger.new(:content_workflow_state => content_state,
                                      :target_state => @mock_target_state)
        content_state.should_receive(:update_attributes).
                with(:workflow_state => @mock_target_state)
        trigger.transition_content
      end
    end
  end

  describe '#activate_if_ready!' do

    it 'should raise an error' do
      lambda {
        WorkflowTrigger.new.activate_if_ready!
      }.should raise_error("implement in subclass")
    end
  end
end

