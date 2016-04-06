class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.string :name
      t.string :address
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
