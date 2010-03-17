require 'spec_helper.rb'

describe Content::TreeNodeContent do

  before(:each) do
    class MockContent; end
    MockContent.stub!(:has_one)
    MockContent.stub!(:validates_presence_of)
    class MockContent
      include Content::TreeNodeContent
    end
  end

  it 'validates_presence_of :title' do
    MockContent.should_receive(:validates_presence_of).
      with(:title, :message => 'must be provided')
    class MockContent
      include Content::TreeNodeContent
    end
  end

  describe '#parent' do

    it 'returns its parent node content' do
      node = double('node')
      parent_content = double('content')
      content = MockContent.new
      content.stub!(:node).and_return(node)
      node.should_receive(:parent_content).and_return(parent_content)
      content.parent.should == parent_content
    end
  end

  describe '#children' do

    it 'returns its child node contents' do
      node = double('node')
      child_content = double('content')
      content = MockContent.new
      content.stub!(:node).and_return(node)
      node.should_receive(:child_contents).and_return([child_content])
      content.children.should == [child_content]
    end
  end

  describe '#path' do

    it 'returns its node path' do
      node = double('node', :path => '/foo')
      content = MockContent.new
      content.stub!(:node).and_return(node)
      content.path.should == node.path
    end
  end
end
