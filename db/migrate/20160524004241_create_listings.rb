class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.integer :rent
      t.integer :lease_months
      t.date :available
      t.integer :unit_id

      t.timestamps null: false
    end
    add_index :listings, :unit_id
  end
end
