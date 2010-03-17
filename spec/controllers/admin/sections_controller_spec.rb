$:.unshift File.join(File.dirname(__FILE__), '../..')
require 'spec_helper.rb'

describe Admin::SectionsController do

  before(:each) do
    @section = mock_model(Section)
    Section.stub!(:find).with(@section.id.to_s).and_return(@section)
    @controller.stub!(:check_authorization).and_return(true)
  end

  context 'GET index' do

    before(:each) do
      Section.stub!(:all).and_return([@section])
    end

    it 'assigns @sections to all sections' do
      get :index
      assigns[:sections].should == [@section]
    end

    it 'renders site_page_view template' do
      @controller.should_receive(:render).
        with(:template => 'admin/site_page_view',
             :locals => { :partial => 'admin/sections/index' })
      get :index
    end
  end

  context 'GET show' do

    it 'assigns @section to section' do
      get :show, :id => @section.id
      assigns[:section].should == @section
    end

    it 'renders site_page_view template' do
      @controller.should_receive(:render).
        with(:template => 'admin/site_page_view',
             :locals => { :partial => 'admin/sections/show' })
      get :show, :id => @section.id
    end
  end

  context 'GET new' do

    it 'assigns @section to new Section' do
      Section.stub!(:new).and_return(@section)
      get :new
      assigns[:section].should == @section
    end

    it 'renders site_page_edit template' do
      @controller.should_receive(:render).
        with(:template => 'admin/site_page_edit',
             :locals => { :partial => 'admin/sections/new' })
      get :new
    end
  end

  context 'POST create' do

    before(:each) do
      Section.stub!(:new).and_return(@section)
      @section.stub!(:save)
    end

    it 'creates a new Section' do
      Section.should_receive(:new).with('foo' => 'bar')
      post :create, :section => { :foo => 'bar' }
    end

    it 'assigns @section to section' do
      post :create, :section => {}
      assigns[:section].should == @section
    end

    context 'is successful' do

      it 'redirects to the new section' do
        @section.stub!(:save).and_return(true)
        post :create, :section => {}
        response.should redirect_to(admin_section_path(@section))
      end
    end

    context 'is not successful' do

      it 'renders site_page_edit template' do
        @section.stub!(:save).and_return(false)
        @controller.should_receive(:render).
          with(:template => 'admin/site_page_edit',
               :locals => { :partial => 'admin/sections/new' })
        post :create, :section => {}
      end
    end
  end

  context 'GET edit' do

    it 'assigns @section to section' do
      get :edit, :id => @section.id
      assigns[:section].should == @section
    end

    it 'renders site_page_edit template' do
      @controller.should_receive(:render).
        with(:template => 'admin/site_page_edit',
             :locals => { :partial => 'admin/sections/edit' })
      get :edit, :id => @section.id
    end
  end

  context 'PUT update' do

    before(:each) do
      @section.stub!(:update_attributes)
    end

    it 'assigns @section to section' do
      put :update, :id => @section.id, :section => {}
      assigns[:section].should == @section
    end

    it 'updates the section attributes' do
      @section.should_receive(:update_attributes).with('foo' => 'bar')
      put :update, :id => @section.id, :section => { :foo => 'bar' }
    end

    context 'is successful' do

      it 'redirects to the updated section' do
        @section.stub!(:update_attributes).and_return(true)
        put :update, :id => @section.id, :section => {}
        response.should redirect_to(admin_section_path(@section))
      end
    end

    context 'is not successful' do

      it 'renders site_page_edit template' do
        @section.stub!(:update_attributes).and_return(false)
        @controller.should_receive(:render).
          with(:template => 'admin/site_page_edit',
               :locals => { :partial => 'admin/sections/edit' })
        put :update, :id => @section.id, :section => {}
      end
    end
  end

  context 'DELETE destroy' do

    before(:each) do
      @section.stub!(:destroy)
    end

    it 'assigns @section to section' do
      delete :destroy, :id => @section.id
      assigns[:section].should == @section
    end

    it 'destroys the section' do
      @section.should_receive(:destroy)
      delete :destroy, :id => @section.id
    end

    context 'is successful' do

      it 'redirects to the section' do
        @section.stub!(:destroy).and_return(true)
        delete :destroy, :id => @section.id
        response.should redirect_to(admin_sections_path)
      end
    end

    context 'is not successful' do

      it 'renders site_page_view template' do
        @section.stub!(:update_attributes).and_return(false)
        @controller.should_receive(:render).
          with(:template => 'admin/site_page_view',
               :locals => { :partial => 'admin/sections/show' })
        delete :destroy, :id => @section.id
      end
    end
  end
end