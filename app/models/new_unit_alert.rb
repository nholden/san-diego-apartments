class NewUnitAlert < ActiveRecord::Base
  belongs_to :unit
  include Alert
end
