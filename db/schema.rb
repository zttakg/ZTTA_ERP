# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_04_26_111535) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "type", limit: 30
    t.integer "width"
    t.integer "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "phone_number"
    t.integer "discount", default: 0
    t.string "company_name"
    t.string "company_address"
    t.string "company_INN"
    t.string "company_OKPO"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "last_name"
    t.string "client_address"
    t.string "company_legal_address"
    t.string "city"
    t.string "company_city"
    t.string "company_BIC"
    t.string "bank_name"
    t.string "contact_person_name"
    t.string "contact_person_last_name"
    t.string "contact_person_phone_number"
    t.string "settlement_account"
    t.integer "person_type", default: 0
    t.integer "status", default: 0
    t.datetime "banned_before"
    t.text "ban_reason"
    t.string "confirmation_token"
    t.index ["email"], name: "index_clients_on_email", unique: true
    t.index ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true
  end

  create_table "constants", force: :cascade do |t|
    t.float "margin"
    t.float "machine_preparation_time"
    t.decimal "material_preparation_cost", precision: 10, scale: 2
    t.decimal "programming_cost", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "programming_time"
    t.float "work_time"
    t.integer "min_order_sum"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "metalware"
    t.string "cutting"
    t.string "email"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "fb_link"
    t.string "instagram_link"
    t.string "telegram_link"
    t.string "whatsapp_link"
    t.string "whatsapp_link_for_metalware"
    t.string "telegram_link_for_metalware"
  end

  create_table "cut_materials", force: :cascade do |t|
    t.bigint "cut_id"
    t.bigint "material_id"
    t.float "hole_min"
    t.decimal "consumption", precision: 10, scale: 2
    t.integer "speed"
    t.decimal "pierce_price", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cut_id"], name: "index_cut_materials_on_cut_id"
    t.index ["material_id"], name: "index_cut_materials_on_material_id"
  end

  create_table "cuts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "consumable_cost", precision: 10, scale: 2
    t.decimal "overhead_cost", precision: 10, scale: 2
    t.float "height_max"
    t.float "width_max"
  end

  create_table "delivery_payments", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.text "content"
    t.integer "condition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "details", force: :cascade do |t|
    t.string "name"
    t.text "svg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "json"
    t.bigint "client_id"
    t.integer "load_type"
    t.integer "status"
    t.string "attachment"
    t.float "width"
    t.float "height"
    t.bigint "cut_material_id"
    t.integer "count"
    t.float "cut_length"
    t.float "area"
    t.float "mass"
    t.integer "holes_count"
    t.integer "preparation_days"
    t.decimal "price"
    t.text "description"
    t.index ["client_id"], name: "index_details_on_client_id"
    t.index ["cut_material_id"], name: "index_details_on_cut_material_id"
    t.index ["name", "client_id"], name: "index_details_on_name_and_client_id", unique: true
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.string "branch"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "telegram_id"
    t.integer "status", default: 0
    t.bigint "role_id"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_employees_on_role_id"
  end

  create_table "individual_item_shipments", force: :cascade do |t|
    t.bigint "individual_item_id"
    t.bigint "employee_id"
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_individual_item_shipments_on_employee_id"
    t.index ["individual_item_id"], name: "index_individual_item_shipments_on_individual_item_id"
  end

  create_table "individual_items", force: :cascade do |t|
    t.bigint "client_id"
    t.bigint "individual_order_id"
    t.integer "status"
    t.integer "load_type"
    t.string "name"
    t.integer "count"
    t.text "svg"
    t.json "json"
    t.string "attachment"
    t.text "description"
    t.float "width"
    t.float "height"
    t.bigint "cut_material_id"
    t.float "cut_length"
    t.string "cut_name"
    t.string "material_name"
    t.float "material_thickness"
    t.integer "holes_count"
    t.float "area"
    t.float "mass"
    t.integer "preparation_days"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "cart_session_id"
    t.index ["client_id"], name: "index_individual_items_on_client_id"
    t.index ["cut_material_id"], name: "index_individual_items_on_cut_material_id"
    t.index ["individual_order_id"], name: "index_individual_items_on_individual_order_id"
  end

  create_table "individual_orders", force: :cascade do |t|
    t.bigint "client_id"
    t.decimal "total_price"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "last_name"
    t.string "city"
    t.string "client_address"
    t.string "phone_number"
    t.string "email"
    t.string "company_OKPO"
    t.string "company_name"
    t.string "company_INN"
    t.string "company_address"
    t.string "company_legal_address"
    t.string "company_city"
    t.string "company_BIC"
    t.string "bank_name"
    t.string "contact_person_name"
    t.string "contact_person_last_name"
    t.string "contact_person_phone_number"
    t.string "settlement_account"
    t.integer "person_type", default: 0
    t.integer "payment"
    t.integer "delivery_method"
    t.text "comment"
    t.string "delivery_address"
    t.string "bank_address"
    t.string "contact_person_email"
    t.datetime "production_date"
    t.float "production_time"
    t.index ["client_id"], name: "index_individual_orders_on_client_id"
  end

  create_table "materials", force: :cascade do |t|
    t.string "name"
    t.float "thickness"
    t.decimal "price_per_kg", precision: 10, scale: 2
    t.float "width_max"
    t.float "height_max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "in_stock", default: true
    t.float "density"
  end

  create_table "order_histories", force: :cascade do |t|
    t.bigint "individual_order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "employee_id"
    t.string "status_from"
    t.string "status_to"
    t.index ["employee_id"], name: "index_order_histories_on_employee_id"
    t.index ["individual_order_id"], name: "index_order_histories_on_individual_order_id"
  end

  create_table "page_elements", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "element_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.boolean "button", default: false
    t.string "video_link"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "permission", default: {}
  end

  create_table "services", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cover"
    t.string "svg"
  end

  add_foreign_key "cut_materials", "cuts"
  add_foreign_key "cut_materials", "materials"
  add_foreign_key "details", "cut_materials"
  add_foreign_key "employees", "roles"
  add_foreign_key "individual_item_shipments", "employees"
  add_foreign_key "individual_item_shipments", "individual_items"
  add_foreign_key "individual_items", "clients"
  add_foreign_key "individual_items", "cut_materials"
  add_foreign_key "individual_items", "individual_orders"
  add_foreign_key "individual_orders", "clients"
  add_foreign_key "order_histories", "individual_orders"
end
