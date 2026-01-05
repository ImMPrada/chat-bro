# This migration comes from personas_engine (originally 20250309100906)
class RemoveLastNameNullConstraintFromPeople < ActiveRecord::Migration[7.2]
  def change
    change_column_null :personas_engine_people, :last_name, true
  end
end
