# This migration comes from personas_engine (originally 20250307151732)
class AddArchivedToPersonasEngineCompany < ActiveRecord::Migration[7.2]
  def change
    add_column :personas_engine_companies, :archived, :boolean, default: false, null: false
    add_column :personas_engine_companies, :archive_reason, :string
    add_index :personas_engine_companies, :archived
    add_index :personas_engine_companies, :archive_reason
  end
end
