module Alert
  extend ActiveSupport::Concern

  class_methods do
    
    def units_from_last_hour
      units = []

      self.includes(:unit).where("created_at >= ?", 1.hour.ago).each do |alert|
        units.push(alert.unit)
      end

      units
    end

  end
end
