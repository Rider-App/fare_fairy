class CreateTaxiFares < ActiveRecord::Migration
  def change
    create_table :taxi_fares do |t|

      t.timestamps null: false
    end
  end
end
