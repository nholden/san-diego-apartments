class AddBuildingIdToUnits < ActiveRecord::Migration
  def change
    add_column :units, :building_id, :integer
    add_index :units, :building_id
  end
end
