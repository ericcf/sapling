$:.unshift File.join(File.dirname(__FILE__), '../../..')
require 'spec_helper.rb'

describe '/admin/users/_show' do

  before(:each) do
    @user = mock_model(User, :username => 'foo')
    assigns[:user] = @user
  end

  it 'renders username' do
    render
    response.should have_tag('h2',
      :text => "User #{@user.username}")
  end
end
