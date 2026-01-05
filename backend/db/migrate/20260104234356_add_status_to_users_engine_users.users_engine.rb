# This migration comes from users_engine (originally 20250528012627)
class AddStatusToUsersEngineUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users_engine_users, :status, :integer
  end
end
