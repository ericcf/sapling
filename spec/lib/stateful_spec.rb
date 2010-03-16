require 'spec_helper.rb'
require 'mock_model'

describe Stateful do

  before(:each) do
    class StatefulFoo < MockModel
      attr_accessor :content_workflow_state
      def initialize
        set_workflow_state
      end
      include Stateful
    end
  end
end
