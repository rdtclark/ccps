# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_09_123900) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.string "location"
    t.string "details_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "organisation_id", null: false
    t.index ["organisation_id"], name: "index_jobs_on_organisation_id"
  end

  create_table "organisations", force: :cascade do |t|
    t.string "organisation_name"
    t.string "industry"
    t.string "roles_within_company"
    t.string "location"
    t.boolean "job_page_exists"
    t.string "job_page_url"
    t.string "homepage"
    t.string "about"
    t.string "linkedin"
    t.boolean "open_to_spec_app"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "vacancies_listed"
    t.boolean "has_scraper"
  end

  add_foreign_key "jobs", "organisations"
end
