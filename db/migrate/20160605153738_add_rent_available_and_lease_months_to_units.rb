class AddRentAvailableAndLeaseMonthsToUnits < ActiveRecord::Migration
  def change
    add_column :units, :rent, :integer
    add_column :units, :available, :date
    add_column :units, :lease_months, :integer
  end
end
