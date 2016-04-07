class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :lat
      t.string :lng

      t.timestamps null: false
    end
  end
end
