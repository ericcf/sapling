module SharedHelper

  include SaplingUser

  def breadcrumbs(content)
    return unless content
    breadcrumbs = [content]
    parent = content
    while !(parent = parent.parent).nil? do
      breadcrumbs.unshift parent
    end

    breadcrumbs
  end

  def menu_items
    items = []
    root_node = Node.find_by_path('/')
    if root_node
      root_content = root_node.content
      if action_permitted?('show', root_content.workflow_state.name)
        items << root_content
        items += root_content.children.select do |child|
          action_permitted?('show', child.workflow_state.name)
        end
      end
    end

    items
  end

  def action_items
    items = []

    if action_permitted?('update')
      items << link_to('Edit This', File.join('/@edit', "#{@action_url}"), :class => 'action')
    end
    if action_permitted?('destroy')
      items << link_to('Delete This', @action_url, { :confirm => 'Are you sure you want to delete all the items contained here?', :method => :delete, :class => 'destructive' })
    end

    items
  end

  private

  def action_permitted?(action, content_state=nil)
    if @content
      content_state ||= @content.workflow_state.name
    elsif content_state.nil?
      return false
    end

    current_user.is_authorized?(controller.controller_name, action, content_state)
  end
end