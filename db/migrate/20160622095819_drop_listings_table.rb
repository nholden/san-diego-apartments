class DropListingsTable < ActiveRecord::Migration
  def change
    drop_table :listings
  end
end
