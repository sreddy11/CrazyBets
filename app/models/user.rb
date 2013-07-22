class User < ActiveRecord::Base

  def to_param
    user_name
  end

  validates :first_name, :last_name, :presence => true  
  validates :user_name, :presence => true, :uniqueness => true
  validates :password, :length => {:minimum => 6},:if => lambda {|a| a.password.present?}
  validates :email, :presence => :true, :uniqueness => :true, 
    :email_format => { message: "not a valid format" }

  has_secure_password
  
  def send_password_reset
    set_new_token
    self.reset_password_sent_at = Time.zone.now
    save!
    UserMailer.reset_password(self).deliver
  end

  def set_new_token
    begin
      self[:reset_password_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:reset_password_token => self[:reset_password_token])
    self[:reset_password_token]
  end
end

