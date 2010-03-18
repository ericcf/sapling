module ContentHelper

  def content_types
    Content.types
  end

  def title
    (@content and @content.respond_to?(:title)) ? @content.title : 'Sapling: Welcome'
  end

  def sidebar_items
    []
  end

  def internal_link_to(content)
    return if content.new_record?
    parameters = @content == content ? { :class => 'selected' } : {}
    link_to content.title, content.path, parameters
  end

  def content_creation
    action = @content.content_actions.
      find(:first, :conditions => { :action => ContentAction::CREATED })
    return nil unless action
    { :user => action.user, :date => action.created_at }
  end

  def last_content_modification
    action = @content.content_actions.
      find(:last,
           :conditions => { :action => ContentAction::MODIFIED },
           :order => 'created_at')
    return nil unless action
    { :user => action.user, :date => action.created_at }
  end
end