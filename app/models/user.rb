class User < ActiveRecord::Base

  def to_param
    user_name
  end

  validates :first_name, :last_name, :presence => true  
  validates :user_name, :presence => true, :uniqueness => true
  validates :password, :length => {:minimum => 6},:if => lambda {|a| a.password.present?}
  validates :email, :presence => :true, :uniqueness => :true, 
    :email_format => { message: "not a valid format" }
  validates_presence_of :invitation_id, :if => :admin? 
  validates_uniqueness_of :invitation_id, :if => :admin?

  has_many :invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'
  belongs_to :invitation
  has_secure_password
  
  def send_password_reset
    set_new_token
    self.reset_password_sent_at = Time.zone.now
    save!
    UserMailer.reset_password(self).deliver
  end

  def admin?
    self.admin
  end

  def set_new_token
    begin
      self[:reset_password_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:reset_password_token => self[:reset_password_token])
    self[:reset_password_token]
  end

  def admin_invitation_token
    if invitation
      invitation.token
    end
  end

  def admin_invitation_token=(token)
    self.invitation = Invitation.find_by_invite_token(token)
  end
end

