# This migration comes from projects_engine (originally 20250120182912)
class AddCompanyReferenceToProjectsEngineProjects < ActiveRecord::Migration[7.2]
  def change
    add_reference :projects_engine_projects, :company, foreign_key: { to_table: :personas_engine_companies }, null: true
  end
end
