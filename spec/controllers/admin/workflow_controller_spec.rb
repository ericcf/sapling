$:.unshift File.join(File.dirname(__FILE__), '../..')
require 'spec_helper.rb'
require 'mock_model'

describe Admin::WorkflowController do

  before(:each) do
    @content = MockModel.new
    @content.stub!(:id).and_return(1)
    MockModel.stub!(:find).
      with(@content.id.to_s).
      and_return(@content)
    @controller.stub!(:check_authorization).and_return(true)
  end

  context 'PUT update_state' do

    before(:each) do
      @content.stub!(:update_attribute)
      @content.stub!(:path).and_return('/foo')
    end

    it 'assigns @content to content' do
      put :update_state,
        :content_id => @content.id,
        :content_type => @content.class.to_s
      assigns[:content].should == @content
    end

    it 'updates the workflow_state attributes' do
      new_state = WorkflowState.create!(:name => 'foo')
      @content.should_receive(:update_attribute).
        with(:workflow_state, new_state)
      put :update_state,
        :content_id => @content.id,
        :content_type => @content.class.to_s,
        :workflow_state => new_state.name
    end

    context 'is successful' do

      before(:each) do
        @content.stub!(:update_attribute).and_return(true)
        put :update_state,
          :content_id => @content.id,
          :content_type => @content.class.to_s
      end

      it 'redirects to the content' do
        response.should redirect_to(@content.path)
      end

      it 'sets a flash[:notice] message' do
        flash[:notice].should == 'Successfully changed content state.'
      end
    end

    context 'is not successful' do

      before(:each) do
        @content.stub!(:update_attribute).and_return(false)
        put :update_state,
          :content_id => @content.id,
          :content_type => @content.class.to_s
      end

      it 'redirects to the content' do
        response.should redirect_to(@content.path)
      end

      it 'sets a flash[:error] message' do
        flash[:error].should == 'Unable to change content state.'
      end
    end
  end
end
