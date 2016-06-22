class RemoveUnusedColumnsFromUnits < ActiveRecord::Migration
  def change
    remove_column :units, :washer_dryer
    remove_column :units, :patio
  end
end
