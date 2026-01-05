# This migration comes from users_engine (originally 20250123165913)
class CreateUsersEngineAuthStrategies < ActiveRecord::Migration[7.2]
  def change
    create_table :users_engine_auth_strategies do |t|
      t.integer :name, null: false
      t.integer :strategy_type, null: false
      t.json :parameters

      t.timestamps
    end
  end
end
