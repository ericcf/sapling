$:.unshift File.join(File.dirname(__FILE__), '../../..')
require 'spec_helper.rb'

describe '/admin/users/_form' do

  before(:each) do
    assigns[:user] = mock_model(User,
      :password => 'foobar',
      :password_confirmation => 'foobar',
      :username => 'bar',
      :errors => mock_model(ActiveRecord::Errors).as_null_object)
    assigns[:action_url] = '/foo'
    render
  end

  it 'renders text field for username' do
    response.should have_selector('input',
      :type => 'text',
      :name => 'user[username]',
      :value => 'bar')
  end

  it 'renders password field for password' do
    response.should have_selector('input',
      :type => 'password',
      :name => 'user[password]')
  end

  it 'renders password field for password confirmation' do
    response.should have_selector('input',
      :type => 'password',
      :name => 'user[password_confirmation]')
  end

  it 'renders a submit button' do
    response.should have_selector('input',
      :type => 'submit',
      :value => 'Submit')
  end
end
