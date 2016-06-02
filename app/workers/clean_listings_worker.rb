class CleanListingsWorker
  def perform(unit_id)
    unit = Unit.find(unit_id)
    listings = unit.listings 
    recent_listings = unit.listings.where("created_at >= ?", 24.hours.ago)
    recent_listings.each_with_index do |listing, index|
      previous_listing = recent_listings[index-1]
      unless listing == recent_listings.first || listing == recent_listings.last
        if listing.attributes.except("id", "created_at", "updated_at") == previous_listing.attributes.except("id", "created_at", "updated_at")
          listing.destroy 
        end
      end
    end
  end
end
