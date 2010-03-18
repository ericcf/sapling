module Content::Auditable

  def self.included(base)
    base.class_eval do
      has_many :content_actions, :as => :content
    end
  end
end