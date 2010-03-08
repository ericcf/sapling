$:.unshift File.join(File.dirname(__FILE__), '../../..')
require 'spec_helper.rb'

describe 'admin/_index' do

  it 'renders a link back to the site root' do
    render
    response.should have_tag("a[href=#{root_path}]", 'Back to Site')
  end

  it 'renders a link to manage sections' do
    render
    response.should have_tag("a[href=#{admin_sections_path}]",
      'Edit Page Sections')
  end

  it 'renders a link to manage users' do
    render
    response.should have_tag("a[href=#{admin_users_path}]", 'Edit Users')
  end
end