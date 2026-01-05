# This migration comes from projects_engine (originally 20250131145031)
class AddArchivableFieldsToProjectsEngineProjects < ActiveRecord::Migration[7.2]
  def change
    add_column :projects_engine_projects, :archived, :boolean, default: false, null: false
    add_column :projects_engine_projects, :archive_reason, :string, null: true
    add_index :projects_engine_projects, :archived
    add_index :projects_engine_projects, :archive_reason
  end
end
