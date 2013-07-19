class AdminMailer < ActionMailer::Base
  default from: "admin@crazybets.com"

  def invitation(invitation, signup_url)
    @signup_url = signup_url
    mail :to => invitation.recipient_email, :subject =>   'Invitation', :from => 'admin@crazybets.com' 
  end

  def reset_password(user)
    @user = user
    mail :to => @user.email, :subject => "CrazyBets Admin: Reset Password"
  end
end
