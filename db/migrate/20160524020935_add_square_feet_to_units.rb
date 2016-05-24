class AddSquareFeetToUnits < ActiveRecord::Migration
  def change
    add_column :units, :square_feet, :integer
  end
end
