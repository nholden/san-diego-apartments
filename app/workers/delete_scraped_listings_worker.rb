class DeleteScrapedListingsWorker
  def perform
    ScrapedListing.destroy_all
  end
end
