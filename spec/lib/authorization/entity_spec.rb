$:.unshift File.join(File.dirname(__FILE__), '..')
require 'spec_helper.rb'

describe Authorization::Entity do

  class MockEntity
    include Authorization::Entity
  end

  describe '#is_authorized?(:controller_name, :action_name)' do

    before(:each) do
      @controller = 'foo'
      @action = 'bar'
      right = mock_model(Right, :controller => @controller, :action => @action)
      @role = mock_model(Role, :rights => [right])
      @entity = MockEntity.new
      @entity.stub!(:roles).and_return([@role])
    end

    context 'entity has a role with a right allowing the controller action' do

      it 'returns true' do
        @entity.is_authorized?(@controller, @action).should == true
      end
    end

    context 'entity does not have a right allowing the controller action' do

      it 'returns false' do
        @entity.is_authorized?(@controller, 'baz').should == false
      end
    end
  end
end