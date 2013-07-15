class UserMailer < ActionMailer::Base
  default from: "reset_password@CrazyBets.com"
  
  def reset_password(user)
    @user = user
    mail :to => @user.email, :subject => "CrazyBets: Reset Password"
  end
end
