require 'spec_helper.rb'

describe TreeNodeContent do

  before(:each) do
    class MockContent; end
    MockContent.stub!(:has_one)
    MockContent.stub!(:validates_presence_of)
    class MockContent
      include TreeNodeContent
    end
  end

  it 'validates_presence_of :title' do
    MockContent.should_receive(:validates_presence_of).
      with(:title, :message => 'must be provided')
    class MockContent
      include TreeNodeContent
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

  describe TreeNodeContent::Item do

    describe '##types' do

      it 'returns names of classes which include TreeNodeContent' do
        TreeNodeContent::Item.types.clear
        class MockContent
          include TreeNodeContent
        end
        TreeNodeContent::Item.types.should == ['MockContent']
      end
    end

    describe '##find_by_path(:path)' do

      it 'returns nil if no Node exists at :path' do
        Node.stub!(:find_by_path)
        TreeNodeContent::Item.find_by_path('/foo').should be_nil
      end

      it 'returns the content at :path if a Node exists there' do
        content = double('content')
        node = mock_model(Node, :content => content)
        Node.stub!(:find_by_path).with('/foo').and_return(node)
        TreeNodeContent::Item.find_by_path('/foo').should == content
      end
    end
  end
end
