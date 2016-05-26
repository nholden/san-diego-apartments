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
