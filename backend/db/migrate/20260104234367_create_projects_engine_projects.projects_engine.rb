# This migration comes from projects_engine (originally 20250112210830)
class CreateProjectsEngineProjects < ActiveRecord::Migration[7.2]
  def change
    create_table :projects_engine_projects do |t|
      t.string :uuid, index: { unique: true }, null: false
      t.string :name, index: { unique: true }, null: false

      t.timestamps
    end
  end
end
