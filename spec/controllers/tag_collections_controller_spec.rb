$:.unshift File.join(File.dirname(__FILE__), '..')
require 'spec_helper.rb'

describe TagCollectionsController do

  before(:each) do
    tags = []
    tags.stub!(:build)
    @tag_collection = mock_model(TagCollection, :tags => tags)
    TagCollection.stub!(:find).with('1').and_return(@tag_collection)
    @controller.stub!(:check_authorization).and_return(true)
  end

  context 'GET show' do

    it 'assigns @tag_collection to tag_collection' do
      get :show, :id => 1
      assigns[:tag_collection].should == @tag_collection
    end

    it 'renders the site_page_view template' do
      get :show, :id => 1
      response.should render_template('shared/site/site_page_view')
    end
  end

  context 'GET new' do

    it 'assigns @tag_collection to new TagCollection' do
      TagCollection.stub!(:new).and_return(@tag_collection)
      get :new
      assigns[:tag_collection].should == @tag_collection
    end

    it 'renders the new template' do
      get :new
      response.should render_template('tag_collections/new')
    end
  end

  context 'POST create' do

    before(:each) do
      TagCollection.stub!(:new).and_return(@tag_collection)
      @tag_collection.stub!(:save)
    end

    it 'creates a new TagCollection' do
      TagCollection.should_receive(:new).with('foo' => 'bar')
      post :create, :tag_collection => { :foo => 'bar' }
    end

    it 'assigns @tag_collection to tag_collection' do
      post :create, :tag_collection => {}
      assigns[:tag_collection].should == @tag_collection
    end

    context 'is successful' do

      it 'redirects to the new tag_collection' do
        @tag_collection.stub!(:save).and_return(true)
        post :create, :tag_collection => {}
        response.should redirect_to(tag_collection_path(@tag_collection))
      end
    end

    context 'is not successful' do

      it 'renders the new template' do
        @tag_collection.stub!(:save).and_return(false)
        post :create, :tag_collection => {}
        response.should render_template('tag_collections/new')
      end
    end
  end

  context 'GET edit' do

    it 'assigns @tag_collection to tag_collection' do
      get :edit, :id => 1
      assigns[:tag_collection].should == @tag_collection
    end

    it 'renders the edit template' do
      get :edit, :id => 1
      response.should render_template('tag_collections/edit')
    end
  end

  context 'PUT update' do

    before(:each) do
      @tag_collection.stub!(:update_attributes)
    end

    it 'assigns @tag_collection to tag_collection' do
      put :update, :id => 1, :tag_collection => {}
      assigns[:tag_collection].should == @tag_collection
    end

    it 'updates the tag collection attributes' do
      @tag_collection.should_receive(:update_attributes).with('foo' => 'bar')
      put :update, :id => 1, :tag_collection => { :foo => 'bar' }
    end

    context 'is successful' do

      it 'redirects to the updated tag collection' do
        @tag_collection.stub!(:update_attributes).and_return(true)
        put :update, :id => 1, :tag_collection => {}
        response.should redirect_to(tag_collection_path(@tag_collection))
      end
    end

    context 'is not successful' do

      it 'renders the edit template' do
        @tag_collection.stub!(:update_attributes).and_return(false)
        put :update, :id => 1, :tag_collection => {}
        response.should render_template('tag_collections/edit')
      end
    end
  end

  context 'DELETE destroy' do

    before(:each) do
      @tag_collection.stub!(:destroy)
    end

    it 'assigns @tag_collection to tag_collection' do
      delete :destroy, :id => 1
      assigns[:tag_collection].should == @tag_collection
    end

    it 'destroys the tag collection' do
      @tag_collection.should_receive(:destroy)
      delete :destroy, :id => 1
    end

    context 'is successful' do

      it 'redirects to the tag collections index' do
        @tag_collection.stub!(:destroy).and_return(true)
        delete :destroy, :id => 1
        response.should redirect_to(tag_collections_path)
      end
    end

    context 'is not successful' do

      it 'renders the show template' do
        @tag_collection.stub!(:update_attributes).and_return(false)
        delete :destroy, :id => 1
        response.should render_template('tag_collections/show')
      end
    end
  end
end
