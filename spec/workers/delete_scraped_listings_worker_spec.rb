require 'rails_helper'

RSpec.describe DeleteScrapedListingsWorker do
  describe ".perform" do
    Given(:worker) { DeleteScrapedListingsWorker.new }
    Given { 30.times { FactoryGirl.create(:scraped_listing) } }
    
    context "when scraped listings not deleted" do
      Then { ScrapedListing.count == 30 }
    end

    context "when scraped listings deleted" do
      When { worker.perform }
      Then { ScrapedListing.count == 0 }
    end
  end
end
