class Section < ActiveRecord::Base

  has_many :chunks

  def title
    name
  end
  
end
