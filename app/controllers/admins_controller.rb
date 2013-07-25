class AdminsController < ApplicationController

  before_filter :check_invite, :only => [:new]
  before_filter :find_admin, :only => [:show, :edit, :update, :destroy]
  before_filter :require_admin_authentication, :only => [:show, :edit, :update, :destroy]
  before_filter :require_no_authentication, :only => [:new, :create]

  def new
    @admin_user = Admin.new
    @admin_user.invitation = @invitation
    @admin_user.email = @invitation.recipient_email  
  end

  def show
  end

  def edit
  end
    
  def create
    @admin_user = Admin.new(admin_params)
    if @admin_user.save
      session[:user_id] = @admin_user.id
      session[:user_type] = "admin"
      redirect_to @admin_user, :notice => "Admin account successfully created"
    else
      render :new
    end
  end

  def update
    if @admin_user.update(admin_params)
      redirect_to @admin_user, :notice => "Your Account (#{@admin_user.user_name}) has been successfully updated"
      session[:user_id] = @admin_user.id
      session[:user_type] = "admin"
    else
      render :edit
    end
  end

  def destroy
    if @admin_user.destroy
      session[:user_id] = nil
      session[:user_type] = nil
      redirect_to root_url, :notice => "Your account has been deleted."
    else
      redirect_to current_user, :notice => "Sorry, the account could not be deleted"
      render :new
    end
  end
  
  private

  def admin_params
    params.require(:admin).permit(:first_name, :last_name, :user_name, :email, :password, 
                                                 :password_confirmation, :invitation_id) 
  end

  def find_admin
    @admin_user = Admin.find_by_user_name!(params[:id])
  end

  def require_admin_authentication
    unless session[:user_id] == @admin_user.id && session[:user_type] = "admin" 
      flash[:error] = " Unauthorized access"
      redirect_to(root_url)
    end 
  end


  def check_invite
    @invitation = Invitation.find_by_invite_token(params[:invite_token])
    unless @invitation
      flash[:error] = "Unauthorized access"
      if logged_in?
        redirect_to current_user
      else
        redirect_to root_url
      end
    end
  end
end

