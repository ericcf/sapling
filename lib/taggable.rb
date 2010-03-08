module Taggable

  def self.included(base)
    base.class_eval do
      has_many :tag_associations,
        :as => :content
      has_many :tags,
        :through => :tag_associations
    end
  end
end