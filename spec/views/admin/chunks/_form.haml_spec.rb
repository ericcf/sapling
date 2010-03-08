$:.unshift File.join(File.dirname(__FILE__), '../../..')
require 'spec_helper.rb'

describe '/admin/chunks/_form' do

  before(:each) do
    assigns[:chunk] = mock_model(Chunk,
      :name => 'foo',
      :text => 'bar',
      :errors => mock_model(ActiveRecord::Errors).as_null_object)
    assigns[:section] = mock_model(Section)
    assigns[:action_url] = '/foo'
    assigns[:javascripts] = []
    assigns[:stylesheets] = []
    render
  end

  it 'assigns @content to chunk' do
    assigns[:content].should == assigns[:chunk]
  end

  it 'renders a text field for the name' do
    response.should have_selector('input', :type => 'text',
      :name => 'chunk[name]',
      :value => 'foo')
  end

  it 'renders a textarea for the text' do
    response.should have_selector('textarea',
      :name => 'chunk[text]',
      :content => 'bar')
  end

  it 'renders a submit button' do
    response.should have_selector('input', :type => 'submit')
  end
end