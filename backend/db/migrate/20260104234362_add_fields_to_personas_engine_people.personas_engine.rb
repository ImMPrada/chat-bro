# This migration comes from personas_engine (originally 20250122233710)
class AddFieldsToPersonasEnginePeople < ActiveRecord::Migration[7.2]
  def change
    change_table :personas_engine_people do |t|
      t.string :work_title
      t.string :avatar_url
      t.references :work_position, null: true, foreign_key: { to_table: :personas_engine_work_positions }
      t.references :user, null: true, foreign_key: { to_table: :users_engine_users }
    end
  end
end
