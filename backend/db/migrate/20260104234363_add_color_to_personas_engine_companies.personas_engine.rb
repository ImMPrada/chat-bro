# This migration comes from personas_engine (originally 20250214001126)
class AddColorToPersonasEngineCompanies < ActiveRecord::Migration[7.2]
  def change
    add_column :personas_engine_companies, :color, :string
  end
end
