$:.unshift File.join(File.dirname(__FILE__), '../../..')
require 'spec_helper.rb'

describe '/admin/chunks/_show' do

  before(:each) do
    @chunk = mock_model(Chunk, :name => 'foo', :text => 'bar')
    assigns[:chunk] = @chunk
    @section = mock_model(Section, :name => 'foo section')
    assigns[:section] = @section
    render
  end

  it 'renders text' do
    response.should contain(@chunk.text)
  end

  it 'renders link to section' do
    response.should have_selector('p') do |p|
      p.should have_tag("a[href=#{admin_section_path(@section)}]",
        "Back to #{@section.name}")
    end
  end
end
