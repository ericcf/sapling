require 'spec_helper'

describe 'UserActions' do
  include Webrat::Matchers

  context 'login form' do

    before(:each) do
      get user_login_form_path
    end

    it 'renders a text field for the username' do
      response.should have_tag('input[type=text]', :name => 'user[username]')
    end

    it 'renders a password field for the password' do
      response.should have_tag('input[type=text]', :name => 'user[password]')
    end

    it 'renders a submit button' do
      response.should have_tag('input[type=submit]')
    end

    context 'user submits login form' do

      before(:each) do
        User.create!(:username => 'foo',
          :password => 'bar',
          :password_confirmation => 'bar')
      end

      context 'with correct credentials' do

        it 'redirects to root_url' do
          post user_login_path,
            :'user[username]' => 'foo',
            :'user[password]' => 'bar'
          response.should redirect_to(root_url)
        end

        it 'displays confirmation text' do
          post_via_redirect user_login_path,
            :'user[username]' => 'foo',
            :'user[password]' => 'bar'
          response.should contain('You are now logged in.')
        end
      end

      context 'with incorrect credentials' do

        it 'redirects to user_login_form' do
          post user_login_path,
            :'user[username]' => 'foo',
            :'user[password]' => 'baz'
          response.should redirect_to(user_login_form_url)
        end

        it 'displays error text' do
          post_via_redirect user_login_path,
            :'user[username]' => 'foo',
            :'user[password]' => 'baz'
          response.should contain('Username or password invalid.')
        end
      end
    end
  end
end
