# This migration comes from users_engine (originally 20250113213314)
class CreateUsersEngineRoleFeatures < ActiveRecord::Migration[7.2]
  def change
    create_table :users_engine_role_features do |t|
      t.references :role, null: false, foreign_key: { to_table: :users_engine_roles }
      t.references :feature, null: false, foreign_key: { to_table: :users_engine_features }

      t.timestamps
    end
  end
end
