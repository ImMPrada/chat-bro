# This migration comes from users_engine (originally 20250113213147)
class CreateUsersEngineFeatures < ActiveRecord::Migration[7.2]
  def change
    create_table :users_engine_features do |t|
      t.string :code, null: false, index: { unique: true }
      t.string :description, null: false

      t.timestamps
    end
  end
end
