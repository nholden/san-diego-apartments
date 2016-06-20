class RenameBuildingsListingsUrlColumn < ActiveRecord::Migration
  def change
    rename_column :buildings, :listings_url, :website
  end
end
