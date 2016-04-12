class RemoveTokenFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :token, :string
  end
end
