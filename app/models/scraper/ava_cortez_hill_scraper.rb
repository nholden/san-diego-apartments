class Scraper::AvaCortezHillScraper < Scraper
  LISTINGS_URL = "https://api.avalonbay.com/json/reply/ApartmentSearch?communityCode=CA060"

  private

  def self.building_name
    "Ava Cortez Hill"
  end

  def self.address
    "1399 Ninth Avenue"
  end

  def self.website
    "http://www.avaloncommunities.com/california/san-diego-apartments/ava-cortez-hill"
  end

  def self.json
    JSON.load(open(LISTINGS_URL))
  end

  def self.floor_plans
    floor_plan_types = json["results"]["availableFloorPlanTypes"]
    floor_plans = []
    floor_plan_types.each { |floor_plan_type| floor_plans.push(floor_plan_type["availableFloorPlans"]) }
    floor_plans.flatten
  end

  def self.raw_listings
    raw_listings = []
    floor_plans.each do |floor_plan|
      floor_plan["finishPackages"].each do |package|
        package["apartments"].each do |apartment|
          apartment = apartment
          apartment["estimatedSize"] = floor_plan["estimatedSize"]
          apartment["floorPlanType"] = floor_plan["floorPlanType"]
          raw_listings.push(apartment)
        end
      end
    end
    raw_listings
  end

  def self.unit_name(raw_listing)
    raw_listing["apartmentNumber"]
  end

  def self.rent(raw_listing)
    raw_listing["pricing"]["effectiveRent"]
  end

  def self.available(raw_listing)
    timestamp = raw_listing["pricing"]["availableDate"].match(/\d+/)[0].to_i / 1000
    Time.at(timestamp).utc.to_date
  end

  def self.beds(raw_listing)
    case raw_listing["floorPlanType"]
    when "Studio"
      return 0
    when "1 bedroom"
      return 1
    when "2 bedrooms"
      return 2
    end
  end

  def self.square_feet(raw_listing)
    raw_listing["estimatedSize"]
  end

  def self.lease_months(raw_listing)
    12
  end
end
