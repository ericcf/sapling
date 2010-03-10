$:.unshift File.join(File.dirname(__FILE__), '..')
require 'spec_helper.rb'

describe UsersController do

  context 'GET login_form' do

    it 'assigns @user to new User' do
      user = mock_model(User)
      User.stub!(:new).and_return(user)
      get :login_form
      assigns[:user].should == user
    end

    it 'assigns @content_partial to users/login_form' do
      get :login_form
      assigns[:content_partial].should == 'users/login_form'
    end

    it 'assigns @action_url to root_url' do
      get :login_form
      assigns[:action_url].should == root_url
    end

    it 'renders the minimal_view template' do
      get :login_form
      response.should render_template('shared/site/minimal_view')
    end
  end

  context 'POST login' do

    it 'authenticates the user' do
      User.should_receive(:authenticate).with('foo' => 'bar')
      post :login, :user => { :foo => 'bar' }
    end

    context 'user authenticates successfully' do

      before(:each) do
        @user = mock_model(User)
        User.stub!(:authenticate).and_return(@user)
      end

      it 'saves the user id to the session' do
        post :login, :user => {}
        session[:user].should == @user.id
      end

      it 'sets a flash notice' do
        post :login, :user => {}
        flash[:notice].should == 'You are now logged in.'
      end

      it 'redirects to root_url' do
        post :login, :user => {}
        response.should redirect_to(root_url)
      end
    end

    context 'user does not authenticate successfully' do

      before(:each) do
        @user = mock_model(User)
        User.stub!(:authenticate).and_return(nil)
      end

      it 'sets the session user to nil' do
        session[:user] = 1
        post :login, :user => {}
        session[:user].should be_nil
      end

      it 'sets a flash error notice' do
        post :login, :user => {}
        flash[:error].should == 'Username or password invalid.'
      end

      it 'redirects to login_form' do
        post :login, :user => {}
        response.should redirect_to(:action => :login_form)
      end
    end
  end

  context 'GET logout' do

    it 'sets the session user to nil' do
      session[:user] = 1
      get :logout
      session[:user].should be_nil
    end

    it 'sets a flash notice' do
      get :logout
      flash[:notice].should == 'You are now logged out.'
    end

    it 'redirects to root_url' do
      get :logout
      response.should redirect_to(root_url)
    end
  end
end