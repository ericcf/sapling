require 'spec_helper'

describe DateWorkflowTrigger do

  before(:each) do
    @valid_cws = mock_model(ContentWorkflowState, :valid? => true)
    @valid_state = mock_model(WorkflowState, :valid? => true)
  end

  it 'is valid with valid attributes' do
    DateWorkflowTrigger.new(:activate_at => Time.now,
                            :content_workflow_state => @valid_cws,
                            :target_state => @valid_state).should be_valid
  end

  describe '#activate_if_ready!' do

    context 'activate_at occurs in the future' do

      it 'does not call transition_content' do
        trigger = DateWorkflowTrigger.create!(:activate_at => Time.now + 1000,
                                              :content_workflow_state => @valid_cws,
                                              :target_state => @valid_state)
        trigger.should_not_receive(:transition_content)
        trigger.activate_if_ready!
      end
    end

    context 'activate_at occurs in the past' do

      it 'does not call transition_content' do
        trigger = DateWorkflowTrigger.create!(:activate_at => Time.now - 1000,
                                              :content_workflow_state => @valid_cws,
                                              :target_state => @valid_state)
        trigger.should_receive(:transition_content)
        trigger.activate_if_ready!
      end
    end
  end
end