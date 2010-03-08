$:.unshift File.join(File.dirname(__FILE__), '../../..')
require 'spec_helper.rb'

describe '/admin/sections/_index' do

  before(:each) do
    @section = mock_model(Section, :name => 'foo')
    assigns[:sections] = [@section]
  end

  it 'renders links to view sections' do
    render
    response.should have_tag("a[href=#{admin_section_path(@section.id)}]",
      :text => @section.name)
  end
  
  it 'renders links to edit sections' do
    render
    response.should have_tag("a[href=#{edit_admin_section_path(@section.id)}]",
      :text => 'Edit')
  end

  it 'renders a link to add a new section' do
    render
    response.should have_tag("a[href=#{new_admin_section_path}]",
      :text => 'Add Section')
  end
end
