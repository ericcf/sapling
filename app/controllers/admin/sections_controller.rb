module Admin

  class SectionsController < AdminController

    layout 'top'

    def index
      @sections = Section.all
      render :template => 'admin/site_page_view', :locals => { :partial => 'admin/sections/index' }
    end

    def show
      @section = Section.find(params[:id])
      render :template => 'admin/site_page_view', :locals => { :partial => 'admin/sections/show' }
    end

    def new
      @section = Section.new
      @action_url = admin_sections_path
      render :template => 'admin/site_page_edit', :locals => { :partial => 'admin/sections/new' }
    end

    def create
      @section = Section.new(params[:section])

      if @section.save
        redirect_to admin_section_path(@section)
      else
        flash.now[:error] = 'Error creating Section.'
        render :template => 'admin/site_page_edit', :locals => { :partial => 'admin/sections/new' }
      end
    end

    def edit
      @section = Section.find(params[:id])
      @action_url = admin_section_path(@section)
      render :template => 'admin/site_page_edit', :locals => { :partial => 'admin/sections/edit' }
    end

    def update
      @section = Section.find(params[:id])

      if @section.update_attributes(params[:section])
        redirect_to admin_section_path(@section)
      else
        flash.now[:error] = 'Error updating Section.'
        render :template => 'admin/site_page_edit', :locals => { :partial => 'admin/sections/edit' }
      end
    end

    def destroy
      @section = Section.find(params[:id])

      if @section.destroy
        redirect_to admin_sections_path
      else
        flash.now[:error] = 'Error deleting Section.'
        render :template => 'admin/site_page_view', :locals => { :partial => 'admin/sections/show' }
      end
    end
  end
end
