class CreateSessionTokens < ActiveRecord::Migration
  def change
    create_table :session_tokens do |t|
      t.integer :user_id
      t.string :token

      t.timestamps null: false
    end
  end
end
