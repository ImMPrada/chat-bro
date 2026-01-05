# This migration comes from projects_engine (originally 20250203212558)
class AddColorFieldToProjectsEngineProjects < ActiveRecord::Migration[7.2]
  def change
    add_column :projects_engine_projects, :color, :string
    add_index :projects_engine_projects, %i[color company_id]
  end
end
