class NodesController < ApplicationController

  include Authorization::Controller
  include SaplingUser

  before_filter :get_context_node
  before_filter :apply_workflow_triggers

  before_filter do |controller|
    unless controller.context_content.nil?
      controller.check_authorization(controller.current_user,
        controller.action_name,
        controller.context_content.workflow_state.name)
    end
  end

  layout 'top'

  def node_list
    @node_list = Node.paginate :page => params[:page]
    render :partial => 'shared/forms/reference_selection_form'
  end

  def context_content
    @context_node.content
  end

  def welcome
    @content_partial = 'shared/site/welcome'
    render :template => 'shared/site/site_page_view'
  end

  def show
    if @context_node.new_record?
      welcome
    else
      @content = @context_node.content
      @content_partial = 'shared/content/view'
      render :template => 'shared/site/site_page_view'
    end
  end

  def new
    new_type = params[:new_type]
    @content = eval(new_type.to_s).new
    render :template => 'shared/site/site_page_edit', :locals => { :f_method => :post }
  end

  def create
    child_node, @content = @context_node.create_child_content(params)

    if @content and @content.valid?
      expire_fragment(:action => 'show')
      ContentAction.create(:content => @content,
                           :user_id => current_user_id,
                           :action => 'created')
      flash.now[:notice] = "#{@content.class} was successfully created."
      redirect_to child_node.path
    else
      flash.now[:error] = "Error creating #{params[:new_type]}: please fix problems indicated below."
      render :template => 'shared/site/site_page_edit', :locals => { :f_method => :post }
    end
  end

  def edit
    @content = @context_node.content unless @context_node.new_record?
    render :template => 'shared/site/site_page_edit', :locals => { :f_method => :put }
  end

  def update
    @content = @context_node.content
    content_param = @content.class.to_s.underscore.to_sym

    if @content.update_attributes(params[content_param])
      expire_fragment(:action => 'show')
      ContentAction.create(:content => @content,
                           :user_id => current_user_id,
                           :action => 'modified')
      flash.now[:notice] = "#{@content.class} was successfully updated."
      redirect_to @context_node.path
    else
      flash.now[:error] = "Error updating #{@content.class}: please fix problems indicated below."
      render :template => 'shared/site/site_page_edit', :locals => { :f_method => :put }
    end
  end

  def destroy
    content = @context_node.content
    classname = content.class.to_s
    parent_content = content.parent
    @context_node.destroy
    expire_fragment(:action => 'show')
    flash.now[:notice] = "Successfully deleted #{classname}."

    if parent_content
      redirect_to parent_content.path
    else
      redirect_to '/'
    end
  end

  private

  # parse the node_path param and return the node it references
  def get_context_node
    context_path = '/' + (params[:node_path] || []).join('/')
    @context_node = Node.find_by_path(context_path)
    if @context_node.nil? and context_path == '/'
      @context_node = Node.new(:path => context_path)
    end
    @action_url = @context_node.path
  end

  # this will blow up unless config.cache_classes = true for the current environment
  def apply_workflow_triggers
    if @context_node.content
      @context_node.content.apply_workflow_triggers!
    end
  end
end
