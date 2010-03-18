module Content::TreeNodeContent

  def self.included(base)
    base.class_eval do
      validates_presence_of :title,
        :message => 'must be provided'
      has_one :node, :as => :content
    end
  end

  def parent
    node.nil? ? nil : node.parent_content
  end

  def children
    node.nil? ? [] : node.child_contents
  end

  def path
    node.nil? ? nil : node.path
  end
end