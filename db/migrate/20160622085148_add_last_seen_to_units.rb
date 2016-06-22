class AddLastSeenToUnits < ActiveRecord::Migration
  def change
    add_column :units, :last_seen, :datetime
  end
end
