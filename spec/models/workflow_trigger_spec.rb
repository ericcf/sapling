require 'spec_helper.rb'
require 'mock_model'

describe WorkflowTrigger do

	before(:each) do
		@valid_cws = mock_model(ContentWorkflowState, :valid? => true)
		@valid_wt = mock_model(WorkflowTransition, :valid? => true)
	end

  it 'is valid with valid attributes' do
		WorkflowTrigger.new(:content_workflow_state => @valid_cws,
		  :workflow_transition => @valid_wt).should be_valid 
  end

  it 'is not valid without a content_workflow_state' do
    WorkflowTrigger.new(:content_workflow_state => nil,
			:workflow_transition => @valid_wt).should_not be_valid
  end

  it 'is not valid without a valid content_workflow_state' do
    cws = mock_model(ContentWorkflowState, :valid? => false)
    WorkflowTrigger.new(:content_workflow_state => cws,
			:workflow_transition => @valid_wt).should_not be_valid
  end

  it 'is not valid without a workflow_transition' do
    WorkflowTrigger.new(:content_workflow_state => @valid_cws,
			:workflow_transition => nil).should_not be_valid
  end

  it 'is not valid without a valid workflow_transition' do
    wt = mock_model(WorkflowTransition, :valid? => false)
    WorkflowTrigger.new(:content_workflow_state => @valid_cws,
			:workflow_transition => wt).should_not be_valid
  end

	describe '#transition_content' do

		context 'content is in target state' do

			it 'does not change content state' do
				target_state = mock_model(WorkflowState)
				content_state = mock_model(ContentWorkflowState,
				  :workflow_state => target_state,
					:content => mock_model(MockModel)
				)
				transition = mock_model(WorkflowTransition,
				  :before_state => mock_model(WorkflowState),
					:after_state => target_state
			  )
				trigger = WorkflowTrigger.new(:content_workflow_state => content_state, :workflow_transition => transition)
				content_state.should_not_receive(:update_attributes)
				trigger.transition_content
			end
		end

		context 'content is not in target state' do

			it 'changes content state to target state' do
				target_state = mock_model(WorkflowState)
				content_state = mock_model(ContentWorkflowState,
				  :workflow_state => mock_model(WorkflowState),
					:content => mock_model(MockModel)
				)
				transition = mock_model(WorkflowTransition,
				  :before_state => mock_model(WorkflowState),
					:after_state => target_state
			  )
				trigger = WorkflowTrigger.new(:content_workflow_state => content_state, :workflow_transition => transition)
				content_state.should_receive(:update_attributes).
					with(:workflow_state => target_state)
				trigger.transition_content
			end
		end
	end
end

