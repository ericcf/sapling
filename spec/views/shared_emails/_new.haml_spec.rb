require File.dirname(__FILE__) + '/../../spec_helper.rb'

describe '/shared_emails/_new' do

  before(:each) do
    content = double('content', :path => '/')
    assigns[:content] = content
    assigns[:shared_email] = mock_model(SharedEmail,
      :content => content,
      :errors => mock_model(ActiveRecord::Errors).as_null_object).as_null_object
    assigns[:action_url] = '/foo'
    template.stub!(:render_text_field)
  end

  it 'renders a text field for recipient\'s address' do
    assigns[:shared_email].stub!(:recipient).and_return('foo')
    render
    response.should have_selector('input',
      :type => 'text',
      :value => 'foo',
      :name => 'shared_email[recipient]')
  end

  it 'renders a text field for sender\'s address' do
    assigns[:shared_email].stub!(:sender).and_return('foo')
    render
    response.should have_selector('input',
      :type => 'text',
      :value => 'foo',
      :name => 'shared_email[sender]')
  end

  it 'renders a text field for comments' do
    assigns[:shared_email].stub!(:comments).and_return('foo')
    render
    response.should have_selector('input',
      :type => 'text',
      :value => 'foo',
      :name => 'shared_email[comments]')
  end
end