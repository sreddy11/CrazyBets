class UsersController < ApplicationController

  before_filter :find_user, :only => [:show, :edit, :update, :destroy]
  before_filter :require_user_authentication, :only => [:show, :edit, :update, :destroy]
  before_filter :require_no_authentication, :only => [:new, :create]
  
  def show
  end

  def new
    @user = User.new 
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, :notice => "Your Account (#{@user.user_name}) has been successfully created"
      session[:user_id] = @user.id
      session[:user_type] = "non-admin"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, :notice => "Your Account (#{@user.user_name}) has been successfully updated"
      session[:user_id] = @user.id
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      session[:user_id] = nil
      session[:user_type] = nil
      redirect_to root_url, :notice => "Your account has been deleted."
    else
      redirect_to current_user, :notice => "Sorry, the account could not be deleted"
    end
  end

  private

  def find_user
    @user = User.find_by_user_name!(params[:id])
  end

  def require_user_authenication
    unless session[:user_id] = @user.id && session[:user] = "non-admin" 
      flash[:error] = " Unauthorized access"
      redirect_to(root_url)
    end 
  end


  def user_params
    params.require(:user).permit(:first_name, :last_name, :user_name, :email, :password, :password_confirmation, 
                                 :password_digest)
  end
end
