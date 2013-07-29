require 'spec_helper'

describe Metric do

  it { should validate_presence_of(:topic) }
  it { should validate_presence_of(:source).on(:update) }

end
