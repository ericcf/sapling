class TagCollectionsController < ApplicationController

  layout 'top'

  def index
    @tag_collections = TagCollection.paginate :page => params[:page], :per_page => 15
    @content_partial = 'tag_collections/index'
    render :template => 'shared/site/site_page_view'
  end

  def show
    @tag_collection = TagCollection.find(params[:id])
    @content_partial = 'tag_collections/show'
    render :template => 'shared/site/site_page_view'
  end

  def new
    @tag_collection = TagCollection.new
    #@tag_collection.tags.build
    render :template => 'tag_collections/new'
  end

  def create
    @tag_collection = TagCollection.new(params[:tag_collection])

    if @tag_collection.save
      expire_fragment(:controller => :nodes, :action => 'delegate', :action_suffix => 'tag_menu_form')
      flash[:notice] = 'TagCollection was successfully created.'
      redirect_to @tag_collection
    else
      render :action => :new
    end
  end

  def edit
    @tag_collection = TagCollection.find(params[:id])
    render :template => 'tag_collections/edit'
  end

  def update
    @tag_collection = TagCollection.find(params[:id])

    if @tag_collection.update_attributes(params[:tag_collection])
      expire_fragment(:controller => :nodes, :action => 'delegate', :action_suffix => 'tag_menu_form')
      flash[:notice] = 'TagCollection was successfully updated.'
      redirect_to @tag_collection
    else
      render :action => :edit
    end
  end

  def destroy
    @tag_collection = TagCollection.find(params[:id])

    if @tag_collection.destroy
      expire_fragment(:controller => :nodes, :action => 'delegate', :action_suffix => 'tag_menu_form')
      flash[:notice] = 'TagCollection was successfully removed.'
      redirect_to :action => :index
    else
      flash[:notice] = 'There was an error removing the tag collection.'
      render :action => :show
    end
  end
end
