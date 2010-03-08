$:.unshift File.join(File.dirname(__FILE__), '../../..')
require 'spec_helper.rb'

describe '/admin/sections/_form' do

  before(:each) do
    assigns[:section] = mock_model(Section,
      :name => 'foo',
      :errors => mock_model(ActiveRecord::Errors).as_null_object)
    assigns[:action_url] = '/foo'
  end

  it 'renders a text field for section name' do
    render
    response.should have_selector('input', :type => 'text',
      :name => 'section[name]',
      :value => 'foo')
  end

  it 'renders a submit button' do
    render
    response.should have_selector('input', :type => 'submit')
  end
end
