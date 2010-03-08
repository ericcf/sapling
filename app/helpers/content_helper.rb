module ContentHelper

  include SaplingUser

  def content_types
    TreeNodeContent::Item.types
  end

  def title
    (@content and @content.respond_to?(:title)) ? @content.title : 'Sapling: Welcome'
  end

  def menu_items
    items = []
    root_content = TreeNodeContent::Item.find_by_path('/')
    if root_content
      if action_permitted?('show', root_content.workflow_state.name)
        items << root_content
        items += root_content.children.select do |child|
          action_permitted?('show', child.workflow_state.name)
        end
      end
    end

    items
  end

  def breadcrumbs(content)
    return unless content
    breadcrumbs = [content]
    parent = content
    while !(parent = parent.parent).nil? do
      breadcrumbs.unshift parent
    end

    breadcrumbs
  end

  def sidebar_items
    []
  end

  def internal_link_to(content)
    return if content.new_record?
    parameters = @content == content ? { :class => 'selected' } : {}
    link_to content.title, content.path, parameters
  end

  def action_items
    items = []
    if @content
      if action_permitted?('update')
        items << link_to('Edit This', "#{@action_url}/EDIT", :class => 'action')
      end
      if action_permitted?('destroy')
        items << link_to('Delete This', @action_url, { :confirm => 'Are you sure you want to delete all the items contained here?', :method => :delete, :class => 'destructive' })
      end
    end

    items
  end

  def action_permitted?(action, content_state='private')
    current_user.is_authorized?(controller.controller_name, action, content_state)
  end
end