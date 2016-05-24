class CreateScrapedListings < ActiveRecord::Migration
  def change
    create_table :scraped_listings do |t|
      t.string :unit_name
      t.integer :rent
      t.date :available
      t.integer :beds
      t.integer :square_feet
      t.integer :lease_months

      t.timestamps null: false
    end
  end
end
