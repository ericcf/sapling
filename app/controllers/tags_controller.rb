class TagsController < ApplicationController

  def create_association
    association = TagAssociation.new(params[:tag_association])
    association.save
  end

  def destroy_association
    association = TagAssociation.find(:first, :conditions => params[:tag_association])
    association.destroy
  end
end