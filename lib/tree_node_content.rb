module TreeNodeContent

  class Item

    @@types ||= []

    def Item.types
      @@types
    end

    def Item.find_by_path(path)
      node = Node.find_by_path(path)
      return node.content if node
    end
  end

  def self.included(base)
    base.class_eval do
      TreeNodeContent::Item.types << base.to_s

      validates_presence_of :title,
        :message => 'must be provided'
      has_one :node, :as => :content
    end
  end

  def parent
    node.parent_content
  end

  def children
    node.child_contents
  end

  def path
    node.path
  end
end