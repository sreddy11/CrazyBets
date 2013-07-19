class AdminsController < UsersController

  before_filter :check_invite, :only => [:new]
  def new
    @admin_user = User.new
    @admin_user.invitation = @invitation
    @admin_user.email = @invitation.recipient_email  
  end
  
  def create
    @admin_user = User.new(admin_params)
    @admin_user.admin = true
    if @admin_user.save
      redirect_to admin_path(@admin_user), :notice => "Admin Account (#{@admin_user.user_name}) has been 
      successfully created"
      session[:user_id] = @admin_user.id
    else
      redirect_to new_admin_url(:invite_token => @admin_user.invitation.invite_token)
    end
  end

  private

  def admin_params
    @admin_params = params.require(:user).permit(:first_name, :last_name, :user_name, :email, :password, 
                                                 :password_confirmation, :invitation_id) 
    @admin_params
  end

  def check_invite
    @invitation = Invitation.find_by_invite_token(params[:invite_token])
    unless @invitation
      flash[:error] = "Unauthorized access"
      redirect_to root_url 
    end
  end

end

