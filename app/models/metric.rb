class Metric < ActiveRecord::Base

  validates :topic, presence: true

  validates :source, :presence =>  {:on => :update}

end
