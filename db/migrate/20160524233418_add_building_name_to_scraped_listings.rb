class AddBuildingNameToScrapedListings < ActiveRecord::Migration
  def change
    add_column :scraped_listings, :building_name, :string
  end
end
