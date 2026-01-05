# This migration comes from projects_engine (originally 20250322084047)
class AddDescriptionToProjectsEngineProjects < ActiveRecord::Migration[7.2]
  def change
    add_column :projects_engine_projects, :description, :text
  end
end
