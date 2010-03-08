require 'spec_helper.rb'

describe '/shared/fields/edit/_content_reference' do

  before(:each) do
    @content = mock('content', :foo_id => 1, :foo_type => 'Foo')
    form = ActionView::Helpers::FormBuilder.new(:content, @content, template, {}, nil)
    render :locals => { :form => form, :field_name => :foo }
  end

  it 'renders a text field for the id' do
    response.should have_selector('input',
      :type => 'text',
      :name => 'content[foo_id]',
      :value => '1')
  end

  it 'renders a text field for the type' do
    response.should have_selector('input',
      :type => 'text',
      :name => 'content[foo_type]',
      :value => 'Foo')
  end
end
