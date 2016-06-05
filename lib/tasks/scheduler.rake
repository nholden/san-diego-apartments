task :scrape_camden_tuscany => :environment do
  puts "Scraping #{Scraper::CamdenTuscanyScraper::LISTINGS_URL}..."
  scraped_listings = Scraper::CamdenTuscanyScraper.scrape
  puts "Done scraping Camden Tuscany."

  puts "Running NewListingWorkers on scraped Camden Tuscany listings..."
  scraped_listings.each do |scraped_listing|
    worker = NewListingWorker.new
    worker.perform(scraped_listing.id)
  end
  puts "Done running workers on Camden Tuscany listings."
end

task :scrape_ava_cortez_hill => :environment do
  puts "Scraping #{Scraper::AvaCortezHillScraper::LISTINGS_URL}..."
  scraped_listings = Scraper::AvaCortezHillScraper.scrape
  puts "Done scraping Ava Cortez Hill."

  puts "Running NewListingWorkers on scraped Ava Cortez Hill listings..."
  scraped_listings.each do |scraped_listing|
    worker = NewListingWorker.new
    worker.perform(scraped_listing.id)
  end
  puts "Done running workers on Ava Cortez Hill listings."
end

task :clean_listings => :environment do
  Unit.all.each do |unit|
    puts "Cleaning #{unit.listings.count} listings for #{unit.building.name} unit #{unit.name}."
    worker = CleanListingsWorker.new
    worker.perform(unit.id)
    puts "Done cleaning. #{unit.listings.count} listings remaining for #{unit.building.name} unit #{unit.name}."
  end
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
    Recipient.all.each do |recipient|
      AlertMailer.hourly_email(recipient).deliver_now
    end
  else
    puts "Found no new alerts. Not sending emails."
  end
end
