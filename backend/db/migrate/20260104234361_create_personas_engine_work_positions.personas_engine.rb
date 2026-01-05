# This migration comes from personas_engine (originally 20250122233542)
class CreatePersonasEngineWorkPositions < ActiveRecord::Migration[7.2]
  def change
    create_table :personas_engine_work_positions do |t|
      t.string :code, null: false, index: { unique: true }
      t.json :title_matches

      t.timestamps
    end
  end
end
