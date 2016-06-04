class CreateRentAlerts < ActiveRecord::Migration
  def change
    create_table :rent_alerts do |t|
      t.integer :old_value
      t.integer :new_value
      t.integer :unit_id

      t.timestamps null: false
    end
    add_index :rent_alerts, :unit_id
  end
end
