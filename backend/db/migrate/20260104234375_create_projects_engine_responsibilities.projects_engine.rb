# This migration comes from projects_engine (originally 20250328175812)
class CreateProjectsEngineResponsibilities < ActiveRecord::Migration[7.2]
  def change
    create_table :projects_engine_responsibilities do |t|
      t.string :uuid, index: { unique: true }, null: false
      t.string :name, null: false, index: { unique: true }
      t.string :color, null: false
      t.json :scope_levels, null: false

      t.timestamps
    end
  end
end
