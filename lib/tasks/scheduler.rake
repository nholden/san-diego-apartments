task :scrape_camden_tuscany => :environment do
  puts "Scraping #{Scraper::CamdenTuscanyScraper::LISTINGS_URL}..."
  scraped_listings = Scraper::CamdenTuscanyScraper.scrape
  puts "Done scraping."

  puts "Running NewListingWorkers on scraped listings..."
  scraped_listings.each do |scraped_listing|
    worker = NewListingWorker.new
    worker.perform(scraped_listing.id)
  end
  puts "Done running workers."
end
