# This migration comes from projects_engine (originally 20250401211039)
class AddProjectStatusReferenceAtProjects < ActiveRecord::Migration[7.2]
  def change
    add_reference :projects_engine_projects,
                  :administrative_status,
                  foreign_key: { to_table: :projects_engine_project_statuses }
    add_reference :projects_engine_projects,
                  :technical_status,
                  foreign_key: { to_table: :projects_engine_project_statuses }
  end
end
