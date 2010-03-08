require 'spec_helper.rb'

describe '/shared/fields/edit/_date_select' do

  before(:each) do
    assigns[:javascripts] = []
    assigns[:stylesheets] = []
    @content = double('content', :date => Date.parse('2010-02-05'))
    form = ActionView::Helpers::FormBuilder.new(:content, @content, template, {}, nil)
    @locals = { :label => 'The date',
                :form => form,
                :field_name => :date }
  end

  it 'renders a text field' do
    render :locals => @locals
    response.should have_tag('input[type=text][value=2010-02-05]')
  end
end
