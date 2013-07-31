class Bet < ActiveRecord::Base

  has_and_belongs_to_many :users
  belongs_to :metric1, :class_name => 'Metric'
  belongs_to :metric2, :class_name => 'Metric'

  accepts_nested_attributes_for :metric1, :allow_destroy =>true
  accepts_nested_attributes_for :metric2, :allow_destroy =>true

  validates :metric1, :metric2, :presence => :true

  scope :not_started, where("? < lock_time", Time.now)

end
