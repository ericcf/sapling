$:.unshift File.join(File.dirname(__FILE__), '..')
require 'spec_helper.rb'

describe SharedEmailsController do

  before(:each) do
    @content = mock('content', :path => '/foo')
    @shared_email = mock_model(SharedEmail, :content => @content).as_null_object
    SharedEmail.stub!(:new).and_return(@shared_email)
    @params = { :content_type => 'Foo', :content_id => 1 }
  end

  context 'GET new' do

    before(:each) do
      get :new, @params
    end

    it 'assigns @shared_email to new SharedEmail' do
      assigns[:shared_email].should == @shared_email
    end

    it 'assigns @content to referenced content' do
      assigns[:content].should == @content
    end

    it 'assigns @content_partial to _new' do
      @content_partial = 'shared_emails/new'
    end

    it 'assigns @action_url to request url' do
      assigns[:action_url].should == request.env['REQUEST_PATH']
    end

    it 'renders site_page_view template' do
      response.should render_template('shared/site/site_page_view')
    end
  end

  context 'POST create' do

    before(:each) do
      @shared_email.stub!(:save)
      @params[:shared_email] = {}
    end

    it 'creates a new SharedEmail' do
      SharedEmail.should_receive(:new).
        with('foo' => 'bar')
      @params[:shared_email] = { :foo => 'bar' }
      post :create, @params
    end

    it 'assigns @shared_email to shared_email' do
      post :create, @params
      assigns[:shared_email].should == @shared_email
    end

    it 'assigns @content to referenced content' do
      post :create, @params
      assigns[:content].should == @content
    end

    context 'is successful' do

      before(:each) do
        @shared_email.stub!(:save).and_return(true)
        post :create, @params
      end

      it 'redirects to the new shared_email' do
        response.should redirect_to(@shared_email.content.path)
      end

      it 'sets flash notice' do
        flash[:notice].should == 'Successfully emailed content.'
      end
    end

    context 'is not successful' do

      before(:each) do
        @shared_email.stub!(:save).and_return(false)
      end

      it 'renders site_page_view template' do
        post :create, @params
        response.should render_template('shared/site/site_page_view')
      end

      it 'assigns @content_partial to _new' do
        post :create, @params
        assigns[:content_partial].should == 'shared_emails/new'
      end

      it 'assigns @action_url to request url' do
        post :create, @params
        assigns[:action_url].should == request.env['REQUEST_PATH']
      end

      it 'sets flash error' do
        @controller.instance_eval{flash.stub!(:sweep)}
        post :create, @params
        flash.now[:error].should == 'Error emailing content.'
      end
    end
  end
end