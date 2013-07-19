class AdminMailer < ActionMailer::Base
  default from: "admin@crazybets.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin_mailer.invitation.subject
  #
  def invitation(invitation, signup_url)
    @greeting = "Hi"
    mail :to => invitation.recipient_email, :subject =>   'Invitation', :from => 'admin@crazybets.com', 
      :body =>  { :invitation => invitation, :signup_url => signup_url }
  end
end
