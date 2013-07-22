class AdminMailer < ActionMailer::Base
  default from: "admin@crazybets.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin_mailer.invitation.subject
  #
  def invitation(invitation, signup_url)
    @signup_url = signup_url
    mail :to => invitation.recipient_email, :subject =>   'Invitation', :from => 'admin@crazybets.com' 
  end
  def reset_password(user)
    @user = user
    mail :to => @user.email, :subject => "CrazyBets Admin: Reset Password"
  end

end
