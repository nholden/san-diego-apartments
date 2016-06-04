class CreateAvailableAlerts < ActiveRecord::Migration
  def change
    create_table :available_alerts do |t|
      t.date :old_value
      t.date :new_value
      t.integer :unit_id

      t.timestamps null: false
    end
    add_index :available_alerts, :unit_id
  end
end
