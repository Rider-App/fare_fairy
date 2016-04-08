class DropTaxiFaresTable < ActiveRecord::Migration
  def up
    drop_table :taxi_fares
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
