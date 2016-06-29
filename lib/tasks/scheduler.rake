task :scrape_camden_tuscany => :environment do
  puts "Scraping #{Scraper::CamdenTuscanyScraper::LISTINGS_URL}..."
  scraped_listings = Scraper::CamdenTuscanyScraper.scrape
  puts "Done scraping Camden Tuscany."

  puts "Running UpdateUnitWorkers on scraped Camden Tuscany listings..."
  scraped_listings.each do |scraped_listing|
    worker = UpdateUnitWorker.new
    worker.perform(scraped_listing.id)
  end
  puts "Done running workers on Camden Tuscany listings."
end

task :scrape_ava_cortez_hill => :environment do
  puts "Scraping #{Scraper::AvaCortezHillScraper::LISTINGS_URL}..."
  scraped_listings = Scraper::AvaCortezHillScraper.scrape
  puts "Done scraping Ava Cortez Hill."

  puts "Running UpdateUnitWorkers on scraped Ava Cortez Hill listings..."
  scraped_listings.each do |scraped_listing|
    worker = UpdateUnitWorker.new
    worker.perform(scraped_listing.id)
  end
  puts "Done running workers on Ava Cortez Hill listings."
end

task :scrape_lofts => :environment do
  puts "Scraping #{Scraper::LoftsScraper::LISTINGS_URL}..."
  scraped_listings = Scraper::LoftsScraper.scrape
  puts "Done scraping the Lofts at 707 Tenth."

  puts "Running UpdateUnitWorkers on scraped Lofts at 707 Tenth listings..."
  scraped_listings.each do |scraped_listing|
    worker = UpdateUnitWorker.new
    worker.perform(scraped_listing.id)
  end
  puts "Done running workers on the Lofts at 707 Tenth listings."
end

task :scrape_market_street_village => :environment do
  puts "Scraping #{Scraper::MarketStreetVillageScraper::LISTINGS_URL}..."
  scraped_listings = Scraper::MarketStreetVillageScraper.scrape
  puts "Done scraping Market Street Village."

  puts "Running UpdateUnitWorkers on scraped Market Street Village listings..."
  scraped_listings.each do |scraped_listing|
    worker = UpdateUnitWorker.new
    worker.perform(scraped_listing.id)
  end
  puts "Done running workers on Market Street Village listings."
end

task :scrape_vantage_pointe => :environment do
  puts "Scraping #{Scraper::VantagePointeScraper::LISTINGS_URL}..."
  scraped_listings = Scraper::VantagePointeScraper.scrape
  puts "Done scraping Vantage Pointe."

  puts "Running UpdateUnitWorkers on scraped Vantage Pointe listings..."
  scraped_listings.each do |scraped_listing|
    worker = UpdateUnitWorker.new
    worker.perform(scraped_listing.id)
  end
  puts "Done running workers on Vantage Pointe listings."
end

task :delete_scraped_listings => :environment do
  puts "Deleting #{ScrapedListing.count} scraped listings."
  worker = DeleteScrapedListingsWorker.new
  worker.perform
  puts "Done deleting. #{ScrapedListing.count} scraped listings remaining."
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
