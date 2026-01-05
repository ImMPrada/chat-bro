# This migration comes from projects_engine (originally 20250227200828)
class AddExternalUrlToProjectsEngineProjects < ActiveRecord::Migration[7.2]
  def change
    add_column :projects_engine_projects, :external_url, :string, null: true
  end
end
