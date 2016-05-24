class AddParkingCostToBuildings < ActiveRecord::Migration
  def change
    add_column :buildings, :parking_cost, :integer
  end
end
