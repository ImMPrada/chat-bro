# This migration comes from users_engine (originally 20241228152614)
class CreateOneTimePasswords < ActiveRecord::Migration[7.2]
  def change
    create_table :users_engine_one_time_passwords do |t|
      t.string :type, null: false
      t.string :token, null: false
      t.datetime :expires_at, null: false
      t.datetime :used_at
      t.references :user, null: false, foreign_key: { to_table: :users_engine_users }
      t.references :oauth_application, null: false, foreign_key: true

      t.timestamps
    end
  end
end
