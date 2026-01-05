# This migration comes from users_engine (originally 20250124000856)
class CreateUsersEngineExternalAccessTokens < ActiveRecord::Migration[7.2]
  def change
    create_table :users_engine_external_access_tokens do |t|
      t.references :auth_strategy, null: false, foreign_key: { to_table: :users_engine_auth_strategies }
      t.references :user, null: false, foreign_key: { to_table: :users_engine_users }
      t.text :token, null: false
      t.text :refresh_token
      t.datetime :expires_at

      t.timestamps
    end
  end
end
