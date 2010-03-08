class SharedEmailsController < ApplicationController

  layout 'top'

  def new
    @shared_email = SharedEmail.new(:content_type => params[:content_type],
      :content_id => params[:content_id])
    @content = @shared_email.content
    @content_partial = 'shared_emails/new'
    @action_url = request.env['REQUEST_PATH']
    render :template => 'shared/site/site_page_view'
  end

  def create
    @shared_email = SharedEmail.new(params[:shared_email])
    @shared_email.content_type = params[:content_type]
    @shared_email.content_id = params[:content_id]
    @content = @shared_email.content

    if @shared_email.save
      flash[:notice] = 'Successfully emailed content.'
      redirect_to @content.path
    else
      flash.now[:error] = 'Error emailing content.'
      @content_partial = 'shared_emails/new'
      @action_url = request.env['REQUEST_PATH']
      render :template => 'shared/site/site_page_view'
    end
  end
end
