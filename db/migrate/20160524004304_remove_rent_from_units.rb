class RemoveRentFromUnits < ActiveRecord::Migration
  def change
    remove_column :units, :rent
  end
end
