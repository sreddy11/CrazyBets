class PasswordsController < ApplicationController
  
  before_filter :find_user_by_password_reset_token, :only => [:edit,:update]
  before_filter :check_expired, :only => [:edit,:update]
  
  def create
    @user = User.find_by_email(params[:email]) || Admin.find_by_email(params[:email])
    if @user
      @user.send_password_reset    
      redirect_to root_url, :notice => "E-mail has been sent regarding resetting password."
    else 
      flash[:notice] = "No account matches the e-mail provided."
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(password_params)
      @user.update_attribute(:reset_password_token, nil)
      redirect_to root_url, :notice => "Password has been reset!"
    else
      flash.now[:alert] = "Password did not update. Please try again."
      render :edit       
    end
  end
  
  def new
  end

  private

  def find_user_by_password_reset_token
    @user = User.find_by_reset_password_token(params[:token]) || 
      Admin.find_by_reset_password_token(params[:token])
  end

  def check_expired
    if Time.now - @user.reset_password_sent_at > 4.hours
      redirect_to new_password_path, :alert => "Password reset request has expired."
    end  
  end

  def password_params
    begin
      @parameters = params.require(:user)
    rescue ActionController::ParameterMissing
      @parameters = params.require(:admin)  
    end
      @parameters.permit(:password, :password_confirmation)
  end
end

