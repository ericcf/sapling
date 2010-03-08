$:.unshift File.join(File.dirname(__FILE__), '../..')
require 'spec_helper.rb'

describe Admin::UsersController do

  before(:each) do
    @user = mock_model(User)
    User.stub!(:find)
    @controller.stub!(:check_authorization).and_return(true)
  end

  context 'GET show' do

    it 'assigns @user to user' do
      User.stub!(:find).with(@user.id.to_s).and_return(@user)
      get :show, :id => @user.id
      assigns[:user].should == @user
    end

    it 'renders site_page_view template' do
      @controller.should_receive(:render).
        with(:template => 'admin/site_page_view',
             :locals => { :partial => 'admin/users/show' })
      get :show, :id => @user.id
    end
  end

  context 'GET new' do

    it 'assigns @user to new User' do
      User.stub!(:new).and_return(@user)
      get :new
      assigns[:user].should == @user
    end

    it 'assigns @action_url to users path' do
      get :new
      assigns[:action_url].should == admin_users_path
    end

    it 'renders site_page_edit template' do
      @controller.should_receive(:render).
        with(:template => 'admin/site_page_edit',
             :locals => { :partial => 'admin/users/new' })
      get :new
    end
  end

  context 'POST create' do

    before(:each) do
      User.stub!(:new).and_return(@user)
      @user.stub!(:save)
    end

    it 'creates a new User' do
      User.should_receive(:new).with('foo' => 'bar')
      post :create, :user => { :foo => 'bar' }
    end

    it 'assigns @user to user' do
      post :create, :user => {}
      assigns[:user].should == @user
    end

    context 'is successful' do

      it 'redirects to the new user' do
        @user.stub!(:save).and_return(true)
        post :create, :user => {}
        response.should redirect_to(admin_user_path(@user))
      end
    end

    context 'is not successful' do

      before(:each) do
        @user.stub!(:save).and_return(false)
      end

      it 'renders site_page_edit template' do
        @controller.should_receive(:render).
          with(:template => 'admin/site_page_edit',
               :locals => { :partial => 'admin/users/new' })
        post :create, :user => {}
      end

      it 'assigns @action_url to users path' do
        post :create, :user => {}
        assigns[:action_url].should == admin_users_path
      end
    end
  end

  context 'GET edit' do

    before(:each) do
      User.stub!(:find).with(@user.id.to_s).and_return(@user)
    end

    it 'assigns @user to user' do
      get :edit, :id => @user.id
      assigns[:user].should == @user
    end

    it 'assigns @action_url to user path' do
      get :edit, :id => @user.id
      assigns[:action_url].should == admin_user_path(@user.id)
    end

    it 'renders site_page_edit template' do
      @controller.should_receive(:render).
        with(:template => 'admin/site_page_edit',
             :locals => { :partial => 'admin/users/edit' })
      get :edit, :id => @user.id
    end
  end

  context 'PUT update' do

    before(:each) do
      @user.stub!(:update_attributes)
      User.stub!(:find).with(@user.id.to_s).and_return(@user)
    end

    it 'assigns @user to user' do
      put :update, :id => @user.id, :user => {}
      assigns[:user].should == @user
    end

    it 'updates the user attributes' do
      @user.should_receive(:update_attributes).with('foo' => 'bar')
      put :update, :id => @user.id, :user => { :foo => 'bar' }
    end

    context 'is successful' do

      it 'redirects to the updated user' do
        @user.stub!(:update_attributes).and_return(true)
        put :update, :id => @user.id, :user => {}
        response.should redirect_to(admin_user_path(@user))
      end
    end

    context 'is not successful' do

      it 'renders site_page_edit template' do
        @user.stub!(:update_attributes).and_return(false)
        @controller.should_receive(:render).
          with(:template => 'admin/site_page_edit',
               :locals => { :partial => 'admin/users/edit' })
        put :update, :id => @user.id, :user => {}
      end
    end
  end

  context 'DELETE destroy' do

    before(:each) do
      @user.stub!(:destroy)
      User.stub!(:find).with(@user.id.to_s).and_return(@user)
    end

    it 'assigns @user to user' do
      delete :destroy, :id => @user.id
      assigns[:user].should == @user
    end

    it 'destroys the user' do
      @user.should_receive(:destroy)
      delete :destroy, :id => @user.id
    end

    context 'is successful' do

      it 'redirects to the user' do
        @user.stub!(:destroy).and_return(true)
        delete :destroy, :id => @user.id
        response.should redirect_to(admin_users_path)
      end
    end

    context 'is not successful' do

      it 'renders site_page_view template' do
        @user.stub!(:update_attributes).and_return(false)
        @controller.should_receive(:render).
          with(:template => 'admin/site_page_view',
               :locals => { :partial => 'admin/users/show' })
        delete :destroy, :id => @user.id
      end
    end
  end
end