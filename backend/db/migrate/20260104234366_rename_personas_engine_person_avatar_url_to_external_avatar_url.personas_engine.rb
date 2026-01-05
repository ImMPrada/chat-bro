# This migration comes from personas_engine (originally 20250528033141)
class RenamePersonasEnginePersonAvatarUrlToExternalAvatarUrl < ActiveRecord::Migration[7.2]
  def change
    rename_column :personas_engine_people, :avatar_url, :external_avatar_url
  end
end
