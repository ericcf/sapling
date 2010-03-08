module Admin

  class UsersController < AdminController

    layout 'top'

    def index
      @users = User.all
      render :template => 'admin/site_page_view', :locals => { :partial => 'admin/users/index' }
    end

    def show
      @user = User.find(params[:id])
      render :template => 'admin/site_page_view', :locals => { :partial => 'admin/users/show' }
    end

    def new
      @user = User.new
      @action_url = admin_users_path
      render :template => 'admin/site_page_edit', :locals => { :partial => 'admin/users/new' }
    end

    def create
      @user = User.new(params[:user])

      if @user.save
        flash[:notice] = 'User was successfully created.'
        redirect_to admin_user_path(@user)
      else
        @action_url = admin_users_path
        flash.now[:error] = 'There was an error saving the user.'
        render :template => 'admin/site_page_edit', :locals => { :partial => 'admin/users/new' }
      end
    end

    def edit
      @user = User.find(params[:id])
      @action_url = admin_user_path(@user)
      render :template => 'admin/site_page_edit', :locals => { :partial => 'admin/users/edit' }
    end

    def update
      @user = User.find(params[:id])

      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        redirect_to admin_user_path(@user)
      else
        flash.now[:error] = 'There was an error saving the user.'
        render :template => 'admin/site_page_edit', :locals => { :partial => 'admin/users/edit' }
      end
    end

    def destroy
      @user = User.find(params[:id])

      if @user.destroy
        flash[:notice] = 'User was successfully removed.'
        redirect_to :action => :index
      else
        flash.now[:error] = 'There was an error removing the user.'
        render :template => 'admin/site_page_view', :locals => { :partial => 'admin/users/show' }
      end
    end
  end
end