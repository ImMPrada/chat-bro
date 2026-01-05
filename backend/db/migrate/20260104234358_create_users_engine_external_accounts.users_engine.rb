# This migration comes from users_engine (originally 20250914191357)
class CreateUsersEngineExternalAccounts < ActiveRecord::Migration[7.2]
  def change
    create_table :users_engine_external_accounts do |t|
      t.string :uuid, null: false, index: { unique: true }
      t.string :name
      t.references :user, foreign_key: { to_table: :users_engine_users }
      t.references :external_application, null: false, foreign_key: { to_table: :users_engine_external_applications }
      t.string :access_token
      t.string :refresh_token
      t.datetime :expires_at

      t.timestamps
    end

    add_index :users_engine_external_accounts, :name
  end
end
