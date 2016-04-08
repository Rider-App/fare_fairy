class AddIndexToAddressesTable < ActiveRecord::Migration
  def change
    add_index :addresses, :address
  end
end
