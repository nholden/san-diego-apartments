namespace :units do
  desc "Populate units last_seen columns with created_at date of last listing"
  task :populate_last_seen => :environment do
    ActiveRecord::Base.transaction do
      Unit.all.each do |unit|
        last_seen = unit.listings.last.created_at
        puts "Updating #{unit.building_name} unit #{unit.name} with last_seen of #{last_seen}"
        unit.last_seen = last_seen
        if unit.save
          puts "#{unit.building_name} unit #{unit.name} successfully saved with last_seen of #{last_seen}"
        else
          puts "ERROR"
        end
      end
    end
  end
end
