# This migration comes from users_engine (originally 20250113212106)
class CreateUsersEngineRoles < ActiveRecord::Migration[7.2]
  def change
    create_table :users_engine_roles do |t|
      t.string :uuid, null: false, index: { unique: true }
      t.string :code, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
