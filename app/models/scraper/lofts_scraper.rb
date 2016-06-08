class Scraper::LoftsScraper < Scraper
  LISTINGS_URL = "http://www.thesandiegolofts.com/Apartments/module/property_info/property%5Bid%5D/72603/launch_check_availability/1/"
  AVAILABILITY_URL_BASE = "http://www.thesandiegolofts.com/?module=check_availability&property[id]=72603&action=view_unit_spaces&property_floorplan[id]="

  private

  def self.building_name
    "Lofts at 707 Tenth"
  end

  def self.raw_listings
    raw_listings = []
    LOFTS_FLOORPLANS.each do |floorplan|
      uri = URI(AVAILABILITY_URL_BASE + floorplan["id"].to_s)
      http = Net::HTTP.new(uri.host, 80)
      request = Net::HTTP::Get.new(uri.request_uri)
      cookie = CGI::Cookie.new('PSI_SESSION_PROSPECT_PORTAL', '0654c3387e64316ef6ab333eb43fb854')
      request['Cookie'] = cookie.to_s
      page = Nokogiri::HTML(http.request(request).body)
      unless page.css('.error').present?
        page.css('tr').each_with_index do |row, index|
          raw_listings.push({page: row, beds: floorplan["beds"]}) unless index == 0
        end
      end
    end
    raw_listings
  end

  def self.unit_name(raw_listing)
    raw_listing[:page].css('.unit').text.match(/\d+/)[0]
  end

  def self.rent(raw_listing)
    raw_listing[:page].css('.rent').text.match(/[\d,]+/)[0].gsub(",", "")
  end

  def self.available(raw_listing)
    Date.parse(raw_listing[:page].css('.unit-availability').attribute("title").text)
  end

  def self.beds(raw_listing)
    raw_listing[:beds]
  end

  def self.square_feet(raw_listing)
    raw_listing[:page].css('.sqft').text.gsub(",", "")
  end

  def self.lease_months(raw_listing)
    13
  end
end
