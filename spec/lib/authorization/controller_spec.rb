$:.unshift File.join(File.dirname(__FILE__), '..')
require 'spec_helper.rb'

describe Authorization::Controller do

  class MockController
    include Authorization::Controller
    attr_reader :content_partial
  end

  before(:each) do
    @controller_name = 'foo'
    @action_name = 'bar'
    @controller = MockController.new
    @controller.stub!(:render)
    @controller.stub!(:controller_name).and_return(@controller_name)
    @controller.stub!(:action_name).and_return(@action_name)
    @controller.stub!(:session).and_return({ :user_id => 1 })
  end

  describe '#check_authorization' do

    context 'accessed by anonymous user' do

      before(:each) do
        User.stub!(:find).and_return(nil)
        @user = mock_model(AnonymousUser)
        AnonymousUser.stub!(:new).and_return(@user)
      end

      context 'with a right to the controller action' do

        it 'returns nil' do
          @user.stub!(:is_authorized?).
            with(@controller_name, @action_name, nil).and_return(true)
          @controller.check_authorization(@user, @action_name).should be_nil
        end
      end

      context 'without a right to the controller action' do

        before(:each) do
          @user.stub!(:is_authorized?).
            with(@controller_name, @action_name, nil).and_return(false)
        end

        it 'returns false' do
          @controller.check_authorization(@user, @action_name).should == false
        end

        it 'assigns @content_partial to _unauthorized partial' do
          @controller.check_authorization(@user, @action_name)
          @controller.content_partial.should == 'shared/site/unauthorized'
        end

        it 'renders the minimal_view template' do
          @controller.should_receive(:render).
            with(:template => 'shared/site/minimal_view')
          @controller.check_authorization(@user, @action_name)
        end
      end
    end

    context 'accessed by an authenticated user' do

      before(:each) do
        @user = mock_model(User)
        User.stub!(:find).and_return(@user)
      end

      context 'with a right to the controller action' do

        it 'returns nil' do
          @user.stub!(:is_authorized?).
            with(@controller_name, @action_name, nil).and_return(true)
          @controller.check_authorization(@user, @action_name).should be_nil
        end
      end

      context 'without a right to the action' do

        before(:each) do
          @user.stub!(:is_authorized?).
            with(@controller_name, @action_name, nil).and_return(false)
        end

        it 'returns false' do
          @controller.check_authorization(@user, @action_name).should == false
        end

        it 'assigns @content_partial to _unauthorized partial' do
          @controller.check_authorization(@user, @action_name)
          @controller.content_partial.should == 'shared/site/unauthorized'
        end

        it 'renders the minimal_view template' do
          @controller.should_receive(:render).
            with(:template => 'shared/site/minimal_view')
          @controller.check_authorization(@user, @action_name)
        end
      end
    end
  end
end