# This migration comes from projects_engine (originally 20250401204102)
class CreateProjectsEngineProjectStatuses < ActiveRecord::Migration[7.2]
  def change
    create_table :projects_engine_project_statuses do |t|
      t.string :type, null: false, index: { unique: false }
      t.string :uuid, index: { unique: true }, null: false
      t.string :color, null: false
      t.string :name, null: false
      t.integer :step, null: false

      t.timestamps
    end
  end
end
