class InvitationsController < ApplicationController

  before_filter :check_admin_status

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invitation_params)
    @invitation.sender = current_user
    if @invitation.save
      send_invite
    else
      render :action => 'new'
    end
  end

  private

  def check_admin_status
    unless current_user.admin?
      redirect_to root_url, :error => "Unauthorized Access"
    end
  end

  def send_invite
    if logged_in?
      AdminMailer.invitation(@invitation, new_admin_url(:invite_token => @invitation.invite_token)).deliver
      flash[:notice] = "Invitation has been sent"
      redirect_to current_user
    else
      flash[:notice] = "Something wetn wrong, invite was not sent"
      redirect_to current_user
    end
  end

  def invitation_params
    params.require(:invitation).permit(:recipient_email)
  end


end
