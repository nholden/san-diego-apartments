class CreateNewUnitAlerts < ActiveRecord::Migration
  def change
    create_table :new_unit_alerts do |t|
      t.integer :unit_id

      t.timestamps null: false
    end
    add_index :new_unit_alerts, :unit_id
  end
end
