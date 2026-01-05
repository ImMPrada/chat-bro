# frozen_string_literal: true

# This migration comes from users_engine (originally 20241226023401)
class CreateUsersEngineUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users_engine_users do |t|
      t.string :email, null: false, default: '', index: { unique: true }
      t.string :uuid, null: false, index: { unique: true }
      t.timestamps null: false
    end
  end
end
