class RemoveUnusedBuildingColumns < ActiveRecord::Migration
  def change
    remove_column :buildings, :pet_fee
    remove_column :buildings, :pool
    remove_column :buildings, :gym
    remove_column :buildings, :parking_cost
  end
end
