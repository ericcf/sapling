require 'spec_helper.rb'
require 'mock_model'

describe '/shared/fields/edit/_has_many' do

  class MockModel; include Content::Base end

  before(:each) do
    @content = mock('content', :foos => [])
    assigns[:content] = @content
    @form = ActionView::Helpers::FormBuilder.new(:content, @content, template, {}, nil)
    @locals = { :label => 'The foos', :form => @form, :field_name => :foos, :schema_field => mock('field', :child_classname => 'MockModel') }
  end

  it 'renders _sub_content for each associated object' do
    template.should_receive(:render).
      with(:partial => 'shared/forms/sub_content', :collection => @content.foos, :locals => { :form => @form })
    render :locals => @locals
  end

  it 'renders a link to add child content' do
    render :locals => @locals
    response.should have_tag('a', 'Add a MockModel')
	end
end
