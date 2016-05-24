class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.string :name
      t.string :address
      t.boolean :gym
      t.integer :pet_fee
      t.boolean :pool
      t.string :listings_url

      t.timestamps null: false
    end
  end
end
