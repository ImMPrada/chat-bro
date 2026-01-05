# This migration comes from personas_engine (originally 20240914202917)
class PersonasEngineCreatePeople < ActiveRecord::Migration[7.2]
  def change
    create_table :personas_engine_people do |t|
      t.string :uuid, null: false, index: { unique: true }
      t.string :first_name, null: false
      t.string :middle_name
      t.string :last_name, null: false
      t.string :second_last_name
      t.string :email, index: true

      t.timestamps
    end
  end
end
