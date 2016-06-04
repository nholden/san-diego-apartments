module Alert
  extend ActiveSupport::Concern

  class_methods do
    
    def units_from_last_hour
      units = []
      
      self.where("created_at ?=", 1.hour.ago).each do |alert|
        units.push(alert.unit) if alert.present?
      end

      units
    end
  end
end
