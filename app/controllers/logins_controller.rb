class LoginsController < ApplicationController

  before_filter :require_no_authentication, :only => [:new, :create]
  before_filter :user_or_admin, :only => [:create]
  
  def new
  end

  def create
    if @user && @user.authenticate(login_params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "Login Successful"
      redirect_to @user
    else
      flash.now[:error] = "Login Invalid"
      render(:new)
    end
  end

  def destroy
    session[:user_id] = nil
    session[:user_type] = nil
    flash[:notice] = "Logout Successful"
    redirect_to(request.referer)
  end

  private

  def login_params 
    params[:login] || {}
  end

  def user_or_admin
    @user = User.find_by_user_name(login_params[:user_name])
    if @user
      session[:user_type] = "non-admin"
    else
      @user = Admin.find_by_user_name(login_params[:user_name])
      session[:user_type] = "admin"
    end
  end

end
