# This migration comes from users_engine (originally 20250914190558)
class CreateUsersEngineExternalApplications < ActiveRecord::Migration[7.2]
  def change
    create_table :users_engine_external_applications do |t|
      t.string :uuid, null: false, index: { unique: true }
      t.integer :name, null: false
      t.string :client_id, null: false
      t.string :client_secret, null: false
      t.string :redirect_uri, null: false

      t.timestamps
    end

    add_index :users_engine_external_applications, :name
    add_index :users_engine_external_applications, :client_id
  end
end
