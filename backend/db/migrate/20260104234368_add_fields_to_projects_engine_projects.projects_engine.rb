# This migration comes from projects_engine (originally 20250116105202)
class AddFieldsToProjectsEngineProjects < ActiveRecord::Migration[7.2]
  def change
    add_column :projects_engine_projects, :code, :string, null: false
    add_index :projects_engine_projects, :code, unique: true

    add_reference :projects_engine_projects, :parent, null: true, foreign_key: { to_table: :projects_engine_projects }
  end
end
