require 'spec_helper.rb'
require 'mock_model'

describe Node do

  before(:each) do
    @content = mock_model(MockModel, :id => 1, :valid? => true, :destroyed? => false)
    MockModel.stub!(:find).with(nil).and_return(nil)
    MockModel.stub!(:find).with(1, anything).and_return(@content)
    @node = Node.new(:path => '/foo', :content => @content)
  end

  # database constraints

  it 'enforces path uniqueness at the physical layer' do
    node = Node.new(:path => '/foo')
    node.save(false)
    other_node = Node.new(:path => node.path)
    lambda {
      other_node.save(false)
    }.should raise_error(ActiveRecord::StatementInvalid)
  end

  it 'enforces content uniqueness at the physical layer' do
    node = Node.new(:content_id => 1, :content_type => 'Foo')
    node.save(false)
    other_node = Node.new(:content_id => node.content_id,
      :content_type => node.content_type)
    lambda {
      other_node.save(false)
    }.should raise_error(ActiveRecord::StatementInvalid)
  end

  # validation

  it 'is valid with valid attributes' do
    node = Node.new(:path => '/foo', :content_id => 1, :content_type => 'MockModel')
    node.should be_valid
  end

  it 'is not valid without a path' do
    Node.new(:path => nil,
      :content => @content).should_not be_valid
  end

  it 'is not valid with a duplicate path' do
    other_content = mock_model(MockModel, :id => 2, :valid? => true)
    MockModel.stub!(:find).with(2, anything).and_return(other_content)
    @node.save!
    Node.new(:path => @node.path,
      :content => other_content).should_not be_valid
  end

  it 'is not valid without a valid parent' do
    parent = mock_model(Node, :valid? => false, :id => 2)
    Node.stub!(:find).with(parent.id, anything).and_return(parent)
    Node.new(:path => '/foo',
      :content => @content,
      :parent_id => parent.id).should_not be_valid
  end

  it 'is not valid without a content_id' do
    Node.new(:path => '/value/for/path',
      :content_id => nil,
      :content_type => 'MockContent').should_not be_valid
  end

  it 'is not valid without a content_type' do
    Node.new(:path => '/value/for/path',
      :content_id => 1,
      :content_type => nil).should_not be_valid
  end

  it 'is not valid with duplicate content' do
    @node.save!
    Node.new(:path => '/bar',
      :content => @node.content).should_not be_valid
  end

  it 'is not valid without valid content' do
    content = mock_model(MockModel, :valid? => false)
    Node.new(:path => '/foo', :content => content).should_not be_valid
  end

  it 'is not valid with a path containing characters besides -_a-z0-9' do
    Node.new(:path => '/ ',
      :content => @content).should_not be_valid
    Node.new(:path => '/%^A',
      :content => @content).should_not be_valid
  end

  it 'is not valid unless the path begins with /' do
    Node.new(:path => 'foo',
      :content => @content).should_not be_valid
  end

  # accessors

  describe '#parent_content' do

    it 'returns nil when no parent exists' do
      @node.parent_id = nil
      @node.parent_content.should be_nil
    end

    it 'returns its parent\'s content when a parent exists' do
      parent_node = mock_model(Node, :id => 2)
      Node.stub!(:find).with(parent_node.id, anything).and_return(parent_node)
      parent_content = mock('content')
      parent_node.should_receive(:content).and_return(parent_content)
      @node.parent_id = parent_node.id
      @node.parent_content.should == parent_content
    end
  end

  describe '#child_contents' do

    it 'returns [] when no children exist' do
      @node.child_contents.should == []
    end

    it 'returns a list of contents of child nodes when there are children' do
      child_content = mock('content')
      child_node = mock_model(Node, :content => child_content)
      child_node.should_receive(:content).and_return(child_content)
      @node.stub(:children).and_return([child_node])
      @node.child_contents.should == [child_content]
    end
  end

  # instance methods

  describe '#create_child_content(:params)' do

    before(:each) do
      @content.stub!(:title).and_return 'Title'
      @content.stub!(:slug=)
      @content.stub!(:save).and_return true
    end

    context 'when called on an existing node' do

      it 'creates content' do
        child_content = mock_model(MockModel, :id => 1,
          :valid? => true, :destroyed? => false, :title => 'Title')
        child_content.stub!(:slug=)
        child_content.stub!(:save)
        MockModel.should_receive(:new).
          and_return child_content
        @node.save!
        @node.create_child_content(
          :new_type => 'MockModel',
          :mock_content => {})
      end

      it 'creates a unique slug and path for content' do
        MockModel.stub!(:find).and_return @content
        MockModel.stub!(:new).and_return @content
        root_node = Node.create!(:path => '/',
          :content => @content)
        Node.create!(:path => '/foo',
          :content_id => 2,
          :content_type => 'MockModel')
        @content.stub!(:title).and_return 'Foo'
        Node.should_receive(:create).
          with(:path => '/foo-1', :parent => root_node, :content => anything).
          and_return(true)
        root_node.create_child_content(
          :new_type => 'MockModel',
          :mock_content => {}
        )
      end
    end

    context 'when called on a new root node' do

      it 'creates content at /' do
        MockModel.should_receive(:new).and_return @content
        node = Node.new(:path => '/')
        returned_node, returned_content = node.create_child_content(
          :new_type => 'MockModel',
          :mock_content => {})
        node.content.should == @content
        returned_node.should == node
        returned_node.parent.should be_nil
        returned_content.should == @content
      end
    end
  end

  # lifecycle

  context 'it is destroyed' do

    it 'calls destroy on its children' do
      @content.stub!(:destroy)
      child_node = mock('node')
      @node.stub!(:children).and_return([child_node])
      child_node.should_receive(:destroy)
      @node.destroy
    end

    it 'calls destroy on its content' do
      @content.should_receive(:destroy)
      @node.destroy
    end
  end
end
