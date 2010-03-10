class UsersController < ApplicationController

  layout 'top'

  def login_form
    @user = User.new
    @content_partial = 'users/login_form'
    @action_url = root_url
    render :template => 'shared/site/minimal_view'
  end

  def login
    user = User.authenticate(params[:user])

    if user
      session[:user] = user.id
      flash[:notice] = 'You are now logged in.'
      redirect_to root_url
    else
      session[:user] = nil
      flash[:error] = 'Username or password invalid.'
      redirect_to :action => :login_form
    end
  end

  def logout
    session[:user] = nil
    flash[:notice] = 'You are now logged out.'
    redirect_to root_url
  end
end