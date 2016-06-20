class AddAddressToScrapedListing < ActiveRecord::Migration
  def change
    add_column :scraped_listings, :address, :string
  end
end
