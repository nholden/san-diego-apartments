class DropScrapedListings < ActiveRecord::Migration
  def change
    drop_table :scraped_listings
  end
end
