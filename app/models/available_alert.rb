class AvailableAlert < ActiveRecord::Base
  belongs_to :unit
  include Alert
end
