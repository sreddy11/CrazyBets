class UsersController < ApplicationController

  def show
    @user = User.find_by_user_name!(params[:id])
  end

  def new
    @user = User.new 
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, :notice => "Your Account (#{@user.user_name}) has been successfully created"
      session[:user_id] = @user.id
    else
      render :new
    end
  end

  def edit
    @user = User.find_by_user_name!(params[:id])
  end

  def update
    @user = User.find_by_user_name!(params[:id])
    if @user.update(user_params)
      redirect_to @user, :notice => "Your Account (#{@user.user_name}) has been successfully updated"
      session[:user_id] = @user.id
    else
      render :edit
    end
  end

  def destroy
    if current_user.destroy
      session[:user_id] = nil
      redirect_to root_url, :notice => "Your account has been deleted."
    else
      redirect_to current_user, :notice => "Sorry, the account could not be deleted"
    end
  end

  private
    
  def user_params
    params.require(:user).permit(:first_name, :last_name, :user_name, :email, :password, :password_confirmation, 
                                 :password_digest)
  end

end
