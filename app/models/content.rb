require 'content/base'

module Content
  require 'content/stateful'
  require 'content/taggable'
  require 'content/tree_node_content'

  def acts_like_content
    self.class_eval do
      include Content::Base
      include Content::Stateful
      include Content::Taggable
      include Content::TreeNodeContent
    end
    Content.types << self.to_s
  end

  @@types = []

  def self.types
    @@types
  end
end
