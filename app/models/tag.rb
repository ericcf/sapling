class Tag < ActiveRecord::Base

  belongs_to :tag_collection
  has_many :tag_associations
  has_many :contents,
    :through => :tag_associations
  belongs_to :parent,
    :class_name => 'Tag'
  has_many :children,
    :class_name => 'Tag',
    :foreign_key => :parent_id

  validates_presence_of :label

end
