# This migration comes from projects_engine (originally 20250328175828)
class CreateProjectsEngineProjectResponsibles < ActiveRecord::Migration[7.2]
  def change
    create_table :projects_engine_project_responsibles do |t|
      t.references :project, null: false, foreign_key: { to_table: :projects_engine_projects }
      t.references :responsible, null: false, foreign_key: { to_table: :personas_engine_people }
      t.references :responsibility, null: false, foreign_key: { to_table: :projects_engine_responsibilities }
      t.timestamps
    end
  end
end
