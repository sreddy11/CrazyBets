class Invitation < ActiveRecord::Base

  belongs_to :sender, :class_name => 'Admin'
  has_one :recipient, :class_name => 'Admin'
 
  validates :recipient_email, :presence => true, :email_format => { message: "not a valid format" }

  validate :not_already_registered

  before_create :generate_token

  private

  def not_already_registered
    if Admin.find_by_email(recipient_email) || User.find_by_email(recipient_email)
      errors.add :recipient_email, 'is already registered'
    end
  end

  def generate_token
    self.invite_token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end
end
