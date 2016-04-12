class CreateTaxiHandles < ActiveRecord::Migration
  def change
    create_table :taxi_handles do |t|
      t.string :city
      t.string :state
      t.string :handle

      t.timestamps null: false
    end
  end
end
