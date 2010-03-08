module Admin

  class AdminController < ApplicationController

    include Authorization::Controller
    include SaplingUser
    before_filter do |controller|
      controller.check_authorization(controller.current_user,
        controller.action_name)
    end

    layout 'top'

    def index
      render :template => 'admin/site_page_view', :locals => { :partial => 'admin/index' }
    end
  end
end