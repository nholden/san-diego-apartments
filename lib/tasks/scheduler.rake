task :scrape_camden_tuscany => :environment do
  puts "Scraping #{CamdenTuscanyScraper::LISTINGS_URL}..."
  CamdenTuscanyScraper.scrape
  puts "Done scraping Camden Tuscany."
end

task :scrape_ava_cortez_hill => :environment do
  puts "Scraping #{AvaCortezHillScraper::LISTINGS_URL}..."
  AvaCortezHillScraper.scrape
  puts "Done scraping Ava Cortez Hill."
end

task :scrape_lofts => :environment do
  puts "Scraping #{LoftsScraper::LISTINGS_URL}..."
  LoftsScraper.scrape
  puts "Done scraping the Lofts at 707 Tenth."
end

task :scrape_market_street_village => :environment do
  puts "Scraping #{MarketStreetVillageScraper::LISTINGS_URL}..."
  MarketStreetVillageScraper.scrape
  puts "Done scraping Market Street Village."
end

task :scrape_vantage_pointe => :environment do
  puts "Scraping #{VantagePointeScraper::LISTINGS_URL}..."
  VantagePointeScraper.scrape
  puts "Done scraping Vantage Pointe."
end

task :send_hourly_alert_email => :environment do
  puts "Checking for new alerts."
  if NewUnitAlert.units_from_last_hour.present? || RentAlert.units_from_last_hour.present? || AvailableAlert.units_from_last_hour.present?
    puts "Found new alerts. Sending emails."
    Recipient.subscribed.each do |recipient|
      AlertMailer.hourly_email(recipient).deliver_now
    end
  else
    puts "Found no new alerts. Not sending emails."
  end
end
