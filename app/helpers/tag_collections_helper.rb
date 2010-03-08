module TagCollectionsHelper

  def add_tag_link(name, dom_id, parent_id=nil)
    link_to_function name do |page|
      page.insert_html :bottom, dom_id, :partial => 'tag', :object => Tag.new(:parent_id => parent_id)
    end
  end
end
