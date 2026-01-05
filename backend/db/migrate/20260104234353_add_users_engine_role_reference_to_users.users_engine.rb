# This migration comes from users_engine (originally 20250113213742)
class AddUsersEngineRoleReferenceToUsers < ActiveRecord::Migration[7.2]
  def change
    add_reference :users_engine_users, :role, null: true, foreign_key: { to_table: :users_engine_roles }
  end
end
