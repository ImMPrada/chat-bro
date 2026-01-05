# This migration comes from projects_engine (originally 20250117191334)
class RemoveProjectsEngineProjectsContrains < ActiveRecord::Migration[7.2]
  def change
    remove_index :projects_engine_projects, :name
    change_column_null :projects_engine_projects, :code, true
  end
end
