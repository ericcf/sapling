module ViewSectionsHelper

  # if there is a user-defined Section, render it, otherwise render the default
  def draw(section_name)
    #cache :action => 'index', :part => section_name do
      section = Section.find_by_name(section_name)
      if section
        render :partial => 'shared/site/sections/section',
          :locals => { :section => section_name.to_sym, :chunks => section.chunks }
      else
        render :partial => "shared/site/sections/#{section_name}"
      end
    #end
  end
end