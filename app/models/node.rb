class Node < ActiveRecord::Base

  belongs_to :content, :polymorphic => true
  belongs_to :parent, :class_name => 'Node'
  has_many :children,
    :class_name => 'Node',
    :foreign_key => :parent_id,
    :dependent => :destroy

  validates_presence_of :path
  validates_uniqueness_of :path
  validates_format_of :path,
    :with => /^(?:\/[-_a-z0-9]+)+$|^\/$/

  validates_associated :parent

  validates_presence_of :content
  validates_uniqueness_of :content_id,
    :scope => :content_type
  validates_associated :content

  before_destroy :destroy_content!

  def parent_content
    unless parent_id.blank?
      parent.content
    end
  end

  def child_contents
    children.map do |child|
      child.content
    end
  end

#  def self.find_or_new_by_path(node_path)
#    node = Node.find_by_path(node_path)
#    if node.nil? and node_path == '/'
#      return Node.new(:path => '/')
#    end
#
#    node
#  end

  def create_child_content(params)
    node = nil
    child_content = build_content(params)
    # to prevent duplicate slugs
    Node.transaction do
      slug = Node.unique_slug_for(self.path, child_content)
      child_content.slug = slug
      if child_content.save
        if self.new_record? and self.path == '/'
          self.content = child_content
          self.save
          node = self
        else
          path = Node.nice_path(self.path, slug)
          if (new_node = Node.create(:path => path,
            :content => child_content, :parent => self))
            node = new_node
          end
        end
      end
    end

    return node, child_content
  end

  protected

  def build_content(params)
    new_type = params[:new_type]
    attributes = params[new_type.to_s.underscore.to_sym]

    eval(new_type.to_s).new(attributes)
  end

  def self.nice_path(parent_path, slug)
    "#{parent_path}/#{slug}".gsub(/^\/\//, '/')
  end

  def self.unique_slug_for(parent_path, content)
    # restrict character set
    slug = content.title.gsub(/[^-_a-zA-Z0-9 ]/, '')
    # remove spaces
    slug.gsub!(/ +/, '-')
    # remove duplicate dashes
    slug.gsub!(/--+/, '-')
    # remove duplicate underscores
    slug.gsub!(/__+/, '_')
    # make all lowercase
    slug = slug.downcase
    unique_slug = slug
    count = 0
    while Node.find_by_path(Node.nice_path(parent_path, unique_slug))
      count += 1
      unique_slug = slug + "-#{count}"
    end

    unique_slug
  end

  def destroy_content!
    self.content.destroy
  end
end
