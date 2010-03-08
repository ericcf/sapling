require 'spec_helper.rb'

describe '/shared/fields/edit/_rich_text_area' do

  before(:each) do
    assigns[:javascripts] = []
    assigns[:stylesheets] = []
    @content = double('content', :text => 'Foo')
    form = ActionView::Helpers::FormBuilder.new(:content, @content, template, {}, nil)
    @locals = { :label => 'The text', :form => form, :field_name => :text }
  end

  it 'renders a textarea' do
    render :locals => @locals
    response.should have_tag('textarea', :text => 'Foo')
  end
end
