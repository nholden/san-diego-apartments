class AddWebsiteToScrapedListing < ActiveRecord::Migration
  def change
    add_column :scraped_listings, :website, :string
  end
end
