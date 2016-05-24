class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :name
      t.boolean :washer_dryer
      t.boolean :patio
      t.integer :beds
      t.integer :rent

      t.timestamps null: false
    end
  end
end
