require 'spec_helper'

describe 'NewSites' do
  include Webrat::Matchers

  context 'root page' do

    before(:each) do
      get '/'
    end

    it 'renders the welcome text' do
      response.should contain('Welcome')
    end

    it 'renders the login link' do
      response.should have_tag("a[href=#{user_login_form_url}]", 'log in')
    end
  end
end
