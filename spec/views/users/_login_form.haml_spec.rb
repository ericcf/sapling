$:.unshift File.join(File.dirname(__FILE__), '..', '..')
require 'spec_helper.rb'

describe '/users/_login_form' do

  before(:each) do
    assigns[:user] = mock_model(User,
      :errors => mock_model(ActiveRecord::Errors).as_null_object).as_null_object
    assigns[:action_url] = '/foo'
    assigns[:javascripts] = []
  end

  it 'renders text field for username' do
    assigns[:user].stub!(:username).and_return('foo')
    render
    response.should have_selector('input',
      :type => 'text',
      :value => 'foo',
      :name => 'user[username]')
  end

  it 'renders password field for password' do
    render
    response.should have_selector('input',
      :type => 'password',
      :name => 'user[password]')
  end

  it 'renders submit button' do
    render
    response.should have_tag('input[type=submit][value=Log In]')
  end
end
