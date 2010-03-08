$:.unshift File.join(File.dirname(__FILE__), '..')
require 'spec_helper.rb'

describe NodesController do

  before(:each) do
    state = mock('workflow_state', :name => 'foo')
    @content = mock('content', :workflow_state => state)
    @node = mock_model(Node,
      :path => '/foo',
      :content => @content).as_null_object
    class MockContent; end
    MockContent.stub!(:new)
    Node.stub!(:find_by_path).with('/foo').and_return(@node)
    @controller.stub!(:check_authorization).and_return(true)
  end

  it 'should route node paths correctly' do
    route_for(:controller => 'nodes',
      :action => 'delegate',
      :node_path => ['a', 'b', 'c']).should == '/a/b/c'
  end

  context 'GET welcome' do

    context 'when a root item exists' do

      it 'assigns @content_partial to shared/content/view' do
        root_node = mock_model(Node).as_null_object
        Node.stub!(:find_by_path).with('/').and_return(root_node)
        root_content = @content
        root_node.stub!(:content).and_return(root_content)
        get :welcome
        assigns[:content_partial].should == 'shared/content/view'
      end
    end

    context 'when no root item exists' do

      it 'should assign @content_partial to _welcome' do
        Node.stub!(:find_by_path).with('/').and_return(nil)
        get :welcome
        assigns[:content_partial].should == 'shared/site/welcome'
      end
    end
  end

  context 'GET delegate' do

    it 'assigns @action_url to context node path' do
      @node.stub!(:path).and_return('/foo')
      get :delegate, :node_path => ['foo']
      assigns[:action_url].should == '/foo'
    end

    context 'no action' do

      it 'searches for the node matching the path' do
        Node.should_receive(:find_by_path).with('/foo/bar').and_return(@node)
        get :delegate, :node_path => ['foo', 'bar']
      end

      it 'assigns @content_partial to shared/content/view' do
        get :delegate, :node_path => ['foo']
        assigns[:content_partial].should == 'shared/content/view'
      end
    end

    context 'NEW action' do

      before(:each) do
        @new_content = mock('content')
      end

      it 'assigns @content to new content' do
        MockContent.should_receive(:new).
          and_return(@new_content)
        get :delegate,
          :node_path => ['foo', 'NEW'],
          :new_type => 'MockContent'
        assigns[:content].should == @new_content
      end

      it 'renders template site_page_edit' do
        get :delegate,
          :node_path => ['foo', 'NEW'],
          :new_type => 'MockContent'
        response.should render_template('shared/site/site_page_edit')
      end
    end

    context 'EDIT action' do

      before(:each) do
        get :delegate, :node_path => ['foo', 'EDIT']
      end

      it 'assigns @content to node content' do
        assigns[:content].should == @content
      end

      it 'renders template site_page_edit' do
        response.should render_template('shared/site/site_page_edit')
      end
    end
  end

  context 'POST create' do

    before(:each) do
      @new_content = mock('content', :valid? => nil)
      @new_node = mock_model(Node, :path => '/foo/bar')
      @node.stub!(:create_child_content).and_return([@new_node, @new_content])
    end

    it 'assigns @content to new content' do
      post :create,
        :node_path => ['foo'],
        :new_type => 'MockContent',
        :new_thing => {}
      assigns[:content].should == @new_content
    end

    context 'is successful' do

      before(:each) do
        @new_content.stub!(:valid?).and_return(true)
      end

      it 'redirects to the path for the new content' do
        post :create,
          :node_path => ['foo'],
          :new_type => 'MockContent',
          :new_thing => {}
        response.should redirect_to(@new_node.path)
      end

      it 'sets a flash.now[:notice] message' do
        @controller.instance_eval{flash.stub!(:sweep)}
        post :create,
          :node_path => ['foo'],
          :new_type => 'MockContent',
          :new_thing => {}
        flash.now[:notice].should == "#{@new_content.class} was successfully created."
      end

      context 'context is root' do

        it 'redirects to /' do
          Node.stub!(:find_by_path).with('/').and_return(nil)
          Node.stub!(:new).and_return(@node)
          root_node = mock_model(Node, :path => '/')
          @node.stub!(:create_child_content).and_return([root_node, @new_content])
          post :create,
            :node_path => [],
            :new_type => 'MockContent',
            :new_thing => {}
          response.should redirect_to('/')
        end
      end
    end

    context 'is not successful' do

      before(:each) do
        @new_content.stub!(:valid?).and_return(false)
      end

      it 'sets a flash.now[:error] message' do
        @controller.instance_eval{flash.stub!(:sweep)}
        post :create,
          :node_path => ['foo'],
          :new_type => 'NewThing',
          :new_thing => {}
        flash.now[:error].should == 'Error creating NewThing: please fix problems indicated below.'
      end

      it 'renders template site_page_edit' do
        post :create,
          :node_path => ['foo'],
          :new_type => 'NewThing',
          :new_thing => {}
        response.should render_template('shared/site/site_page_edit')
      end
    end
  end

  context 'PUT update' do

    it 'assigns @content' do
      @content.stub!(:update_attributes)
      put :update,
        :node_path => ['foo']
      assigns[:content].should == @content
    end

    it 'calls update_attributes on the content' do
      @content.should_receive(:update_attributes).with('attr_one' => 1)
      content_param = @content.class.to_s.underscore.to_sym
      put :update,
        :node_path => ['foo'],
        content_param => { :attr_one => 1 }
    end

    context 'is successful' do

      before(:each) do
        @content.stub!(:update_attributes).and_return(true)
      end

      it 'redirects to the path for the updated content' do
        put :update,
          :node_path => ['foo']
        response.should redirect_to(@node.path)
      end

      it 'sets a flash.now[:notice] message' do
        @controller.instance_eval{flash.stub!(:sweep)}
        put :update,
          :node_path => ['foo']
        flash.now[:notice].should == "#{@content.class} was successfully updated."
      end
    end

    context 'is not successful' do

      before(:each) do
        @content.stub!(:update_attributes).and_return(false)
      end

      it 'assigns @action_url to node path' do
        put :update,
          :node_path => ['foo']
        assigns[:action_url].should == @node.path
      end

      it 'sets a flash.now[:error] message' do
        @controller.instance_eval{flash.stub!(:sweep)}
        put :update,
          :node_path => ['foo']
        flash.now[:error].should == "Error updating #{@content.class}: please fix problems indicated below."
      end

      it 'renders the site_page_edit template' do
        put :update,
          :node_path => ['foo']
        @controller.should render_template('shared/site/site_page_edit')
      end
    end
  end

  context 'DELETE destroy' do

    before(:each) do
      @content.stub!(:destroy)
      @content.stub!(:parent)
    end

    it 'calls destroy on the node' do
      @node.should_receive(:destroy)
      delete :destroy,
        :node_path => ['foo']
    end

    it 'sets a flash.now[:notice] message' do
      @controller.instance_eval{flash.stub!(:sweep)}
      delete :destroy,
        :node_path => ['foo']
      flash.now[:notice].should == "Successfully deleted #{@content.class}."
    end

    context 'it has a parent' do

      it 'redirects to the parent path' do
        parent_content = mock('content', :id => 1, :path => '/')
        @content.stub!(:parent).and_return(parent_content)
        delete :destroy,
          :node_path => ['foo']
        response.should redirect_to(parent_content.path)
      end
    end

    context 'it does not have a parent' do

      it 'redirects to the root path' do
        @content.stub!(:parent).and_return(nil)
        delete :destroy,
          :node_path => ['foo']
        response.should redirect_to('/')
      end
    end
  end
end
