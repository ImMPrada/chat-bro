# This migration comes from personas_engine (originally 20250117220452)
class CreatePersonasEngineCompanies < ActiveRecord::Migration[7.2]
  def change
    create_table :personas_engine_companies do |t|
      t.string :uuid, index: { unique: true }, null: false
      t.string :name, null: false, index: true

      t.timestamps
    end
  end
end
