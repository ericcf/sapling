$:.unshift File.join(File.dirname(__FILE__), '../../..')
require 'spec_helper.rb'

describe '/admin/users/_index' do

  before(:each) do
    @user = mock_model(User, :username => 'foo')
    assigns[:users] = [@user]
  end

  it 'renders links to view users' do
    render
    response.should have_tag("a[href=#{admin_user_path(@user.id)}]",
      :text => @user.username)
  end
  
  it 'renders links to edit users' do
    render
    response.should have_tag("a[href=#{edit_admin_user_path(@user.id)}]",
      :text => 'Edit')
  end

  it 'renders a link to add a new user' do
    render
    response.should have_tag("a[href=#{new_admin_user_path}]",
      :text => 'Add User')
  end
end
