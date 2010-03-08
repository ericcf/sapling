class Chunk < ActiveRecord::Base

  belongs_to :section

  validates_associated :section

  def title
    name
  end
  
end
