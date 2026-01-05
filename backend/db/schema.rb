# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2026_01_04_234378) do
  create_table "oauth_access_grants", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "resource_owner_id", null: false
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["resource_owner_id"], name: "index_oauth_access_grants_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "resource_owner_id"
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.string "scopes"
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "personas_engine_companies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
    t.boolean "archived", default: false, null: false
    t.string "archive_reason"
    t.index ["archive_reason"], name: "index_personas_engine_companies_on_archive_reason"
    t.index ["archived"], name: "index_personas_engine_companies_on_archived"
    t.index ["name"], name: "index_personas_engine_companies_on_name"
    t.index ["uuid"], name: "index_personas_engine_companies_on_uuid", unique: true
  end

  create_table "personas_engine_people", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "first_name", null: false
    t.string "middle_name"
    t.string "last_name"
    t.string "second_last_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "work_title"
    t.string "external_avatar_url"
    t.bigint "work_position_id"
    t.bigint "user_id"
    t.index ["email"], name: "index_personas_engine_people_on_email"
    t.index ["user_id"], name: "index_personas_engine_people_on_user_id"
    t.index ["uuid"], name: "index_personas_engine_people_on_uuid", unique: true
    t.index ["work_position_id"], name: "index_personas_engine_people_on_work_position_id"
  end

  create_table "personas_engine_work_positions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "code", null: false
    t.json "title_matches"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_personas_engine_work_positions_on_code", unique: true
  end

  create_table "projects_engine_project_responsibles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "responsible_id", null: false
    t.bigint "responsibility_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_projects_engine_project_responsibles_on_project_id"
    t.index ["responsibility_id"], name: "idx_on_responsibility_id_c2356f0afa"
    t.index ["responsible_id"], name: "index_projects_engine_project_responsibles_on_responsible_id"
  end

  create_table "projects_engine_project_statuses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "type", null: false
    t.string "uuid", null: false
    t.string "color", null: false
    t.string "name", null: false
    t.integer "step", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_projects_engine_project_statuses_on_type"
    t.index ["uuid"], name: "index_projects_engine_project_statuses_on_uuid", unique: true
  end

  create_table "projects_engine_projects", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
    t.bigint "parent_id"
    t.bigint "company_id"
    t.boolean "archived", default: false, null: false
    t.string "archive_reason"
    t.string "color"
    t.string "external_url"
    t.text "description"
    t.bigint "administrative_status_id"
    t.bigint "technical_status_id"
    t.index ["administrative_status_id"], name: "index_projects_engine_projects_on_administrative_status_id"
    t.index ["archive_reason"], name: "index_projects_engine_projects_on_archive_reason"
    t.index ["archived"], name: "index_projects_engine_projects_on_archived"
    t.index ["code"], name: "index_projects_engine_projects_on_code", unique: true
    t.index ["color", "company_id"], name: "index_projects_engine_projects_on_color_and_company_id"
    t.index ["company_id"], name: "index_projects_engine_projects_on_company_id"
    t.index ["parent_id"], name: "index_projects_engine_projects_on_parent_id"
    t.index ["technical_status_id"], name: "index_projects_engine_projects_on_technical_status_id"
    t.index ["uuid"], name: "index_projects_engine_projects_on_uuid", unique: true
  end

  create_table "projects_engine_responsibilities", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "name", null: false
    t.string "color", null: false
    t.json "scope_levels", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_projects_engine_responsibilities_on_name", unique: true
    t.index ["uuid"], name: "index_projects_engine_responsibilities_on_uuid", unique: true
  end

  create_table "users_engine_auth_strategies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "name", null: false
    t.integer "strategy_type", null: false
    t.json "parameters"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users_engine_external_access_tokens", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "auth_strategy_id", null: false
    t.bigint "user_id", null: false
    t.text "token", null: false
    t.text "refresh_token"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auth_strategy_id"], name: "index_users_engine_external_access_tokens_on_auth_strategy_id"
    t.index ["user_id"], name: "index_users_engine_external_access_tokens_on_user_id"
  end

  create_table "users_engine_external_accounts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "name"
    t.bigint "user_id"
    t.bigint "external_application_id", null: false
    t.string "access_token"
    t.string "refresh_token"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_application_id"], name: "idx_on_external_application_id_e358556178"
    t.index ["name"], name: "index_users_engine_external_accounts_on_name"
    t.index ["user_id"], name: "index_users_engine_external_accounts_on_user_id"
    t.index ["uuid"], name: "index_users_engine_external_accounts_on_uuid", unique: true
  end

  create_table "users_engine_external_applications", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "uuid", null: false
    t.integer "name", null: false
    t.string "client_id", null: false
    t.string "client_secret", null: false
    t.string "redirect_uri", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_users_engine_external_applications_on_client_id"
    t.index ["name"], name: "index_users_engine_external_applications_on_name"
    t.index ["uuid"], name: "index_users_engine_external_applications_on_uuid", unique: true
  end

  create_table "users_engine_features", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "code", null: false
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_users_engine_features_on_code", unique: true
  end

  create_table "users_engine_one_time_passwords", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "type", null: false
    t.string "token", null: false
    t.datetime "expires_at", null: false
    t.datetime "used_at"
    t.bigint "user_id", null: false
    t.bigint "oauth_application_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["oauth_application_id"], name: "index_users_engine_one_time_passwords_on_oauth_application_id"
    t.index ["user_id"], name: "index_users_engine_one_time_passwords_on_user_id"
  end

  create_table "users_engine_role_features", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "role_id", null: false
    t.bigint "feature_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feature_id"], name: "index_users_engine_role_features_on_feature_id"
    t.index ["role_id"], name: "index_users_engine_role_features_on_role_id"
  end

  create_table "users_engine_roles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_users_engine_roles_on_code", unique: true
    t.index ["uuid"], name: "index_users_engine_roles_on_uuid", unique: true
  end

  create_table "users_engine_users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "uuid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "role_id"
    t.integer "status"
    t.index ["email"], name: "index_users_engine_users_on_email", unique: true
    t.index ["role_id"], name: "index_users_engine_users_on_role_id"
    t.index ["uuid"], name: "index_users_engine_users_on_uuid", unique: true
  end

  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_grants", "users_engine_users", column: "resource_owner_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "users_engine_users", column: "resource_owner_id"
  add_foreign_key "personas_engine_people", "personas_engine_work_positions", column: "work_position_id"
  add_foreign_key "personas_engine_people", "users_engine_users", column: "user_id"
  add_foreign_key "projects_engine_project_responsibles", "personas_engine_people", column: "responsible_id"
  add_foreign_key "projects_engine_project_responsibles", "projects_engine_projects", column: "project_id"
  add_foreign_key "projects_engine_project_responsibles", "projects_engine_responsibilities", column: "responsibility_id"
  add_foreign_key "projects_engine_projects", "personas_engine_companies", column: "company_id"
  add_foreign_key "projects_engine_projects", "projects_engine_project_statuses", column: "administrative_status_id"
  add_foreign_key "projects_engine_projects", "projects_engine_project_statuses", column: "technical_status_id"
  add_foreign_key "projects_engine_projects", "projects_engine_projects", column: "parent_id"
  add_foreign_key "users_engine_external_access_tokens", "users_engine_auth_strategies", column: "auth_strategy_id"
  add_foreign_key "users_engine_external_access_tokens", "users_engine_users", column: "user_id"
  add_foreign_key "users_engine_external_accounts", "users_engine_external_applications", column: "external_application_id"
  add_foreign_key "users_engine_external_accounts", "users_engine_users", column: "user_id"
  add_foreign_key "users_engine_one_time_passwords", "oauth_applications"
  add_foreign_key "users_engine_one_time_passwords", "users_engine_users", column: "user_id"
  add_foreign_key "users_engine_role_features", "users_engine_features", column: "feature_id"
  add_foreign_key "users_engine_role_features", "users_engine_roles", column: "role_id"
  add_foreign_key "users_engine_users", "users_engine_roles", column: "role_id"
end
