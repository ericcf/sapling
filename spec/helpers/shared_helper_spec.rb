require 'spec_helper'

describe SharedHelper do

  describe '#breadcrumbs(:content)' do

    context 'content is nil' do

      it 'returns nil' do
        helper.breadcrumbs(nil).should be_nil
      end
    end

    context 'content has no parent' do

      it 'returns array containing content' do
        content = mock('content', :parent => nil)
        breadcrumbs = helper.breadcrumbs(content)
        breadcrumbs.size.should == 1
        breadcrumbs.first.should == content
      end
    end

    context 'content has a parent' do

      it 'returns array containing parent before content' do
        parent = mock('content', :parent => nil)
        content = mock('content', :parent => parent)
        breadcrumbs = helper.breadcrumbs(content)
        breadcrumbs.size.should == 2
        breadcrumbs.first.should == parent
        breadcrumbs.last.should == content
      end
    end
  end

  describe '#menu_items' do

    context 'no root node exists' do

      it 'returns []' do
        helper.menu_items.should == []
      end
    end

    context 'root node exists' do

      context 'current user permitted to view root content' do

        before(:each) do
          @state = mock('state', :name => 'foo')
          user = mock_model(User)
          user.stub!(:is_authorized?).
            with(anything, 'show', @state.name).
            and_return(true)
          helper.stub!(:current_user).and_return user
        end

        it 'returns array containing root content' do
          root_content = mock('content',
                              :workflow_state => @state,
                              :children => [])
          root_node = mock_model(Node, :content => root_content)
          Node.stub!(:find_by_path).with('/').and_return(root_node)
          helper.menu_items.should == [root_content]
        end

        context 'root node has child' do

          context 'current user permitted to view child content' do

            it 'returns array containing root and child content' do
              child_content = mock('content',
                                   :workflow_state => @state,
                                   :children => [])
              root_content = mock('content',
                                  :workflow_state => @state,
                                  :children => [child_content])
              root_node = mock_model(Node, :content => root_content)
              Node.stub!(:find_by_path).with('/').and_return(root_node)
              helper.menu_items.should == [root_content, child_content]
            end
          end
        end
      end
    end
  end

  describe '#action_items' do

    before(:each) do
      @state = mock('state', :name => 'foo')
      assigns[:content] = mock('content', :workflow_state => @state)
      @user = mock_model(User)
      @user.stub!(:is_authorized?).and_return(false)
      helper.stub!(:current_user).and_return @user
    end

    context 'current user is permitted to edit context content' do

      it 'displays link to edit' do
        @user.stub!(:is_authorized?).
          with(anything, 'update', @state.name).
          and_return(true)
        action_items = helper.action_items
        action_items.size.should == 1
        action_items.first.should have_tag('a', 'Edit This')
      end
    end

    context 'current user is permitted to delete context content' do

      it 'displays link to delete' do
        @user.stub!(:is_authorized?).
          with(anything, 'destroy', @state.name).
          and_return(true)
        assigns[:action_url] = '/foo'
        action_items = helper.action_items
        action_items.size.should == 1
        action_items.first.should have_tag('a', 'Delete This')
      end
    end
  end
end