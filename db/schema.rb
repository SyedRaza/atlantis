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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110331103838) do

  create_table "address_types", :force => true do |t|
    t.string   "address_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "addresses", :force => true do |t|
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "country_id"
    t.integer  "address_type_id"
    t.float    "lat"
    t.float    "lng"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attached_documents", :force => true do |t|
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.string   "attachment_file_size"
    t.text     "description"
    t.text     "title"
    t.integer  "typeable_id"
    t.string   "typeable_type"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attached_documents_default_types", :force => true do |t|
    t.string  "title"
    t.integer "parent_id"
  end

  create_table "attaches", :force => true do |t|
    t.integer  "size"
    t.integer  "height"
    t.integer  "width"
    t.integer  "parent_id"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.integer  "position"
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "billing_modes", :force => true do |t|
    t.string   "mode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", :force => true do |t|
    t.string   "title"
    t.integer  "industry_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "note"
    t.integer  "user_id"
    t.integer  "updated_by"
  end

  create_table "contact_company_profiles", :force => true do |t|
    t.integer  "contact_id"
    t.integer  "company_id"
    t.date     "active_date"
    t.date     "expire_date"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_directories", :force => true do |t|
    t.string   "directory_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_statuses", :force => true do |t|
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_types", :force => true do |t|
    t.string   "contact_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.text     "additional_info"
    t.integer  "contact_status_id"
    t.integer  "contact_type_id"
    t.integer  "contact_directory_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.string   "note"
    t.integer  "user_id"
    t.integer  "updated_by"
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dev_centers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "email_types", :force => true do |t|
    t.string   "service"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emails", :force => true do |t|
    t.string   "email"
    t.integer  "email_type_id"
    t.integer  "emailable_id"
    t.string   "emailable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "industries", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lead_sources", :force => true do |t|
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lead_statuses", :force => true do |t|
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lead_types", :force => true do |t|
    t.string   "lead_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leads", :force => true do |t|
    t.text     "primary_skills"
    t.text     "situation"
    t.text     "original_email"
    t.integer  "company_id"
    t.integer  "contact_id"
    t.integer  "lead_status_id"
    t.integer  "lead_type_id"
    t.integer  "lead_source_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.integer  "user_id"
    t.integer  "updated_by"
  end

  create_table "meeting_types", :force => true do |t|
    t.string "meeting_type"
  end

  create_table "meetings", :force => true do |t|
    t.date     "date_of_meeting"
    t.string   "location"
    t.text     "attendees"
    t.text     "minutes_of_meeting"
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "meeting_type_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by"
  end

  create_table "messenger_services", :force => true do |t|
    t.string   "service"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messenger_types", :force => true do |t|
    t.string   "messenger_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messengers", :force => true do |t|
    t.string   "title"
    t.integer  "messenger_service_id"
    t.integer  "messenger_type_id"
    t.integer  "messengerable_id"
    t.string   "messengerable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "note_generals", :force => true do |t|
    t.text   "description"
    t.string "attachment_file_name"
    t.string "attachment_content_type"
    t.string "attachment_file_size"
  end

  create_table "note_types", :force => true do |t|
    t.integer "user_id"
    t.string  "title"
    t.string  "class_name"
    t.integer "position"
    t.string  "ancestry"
  end

  create_table "notes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "note_type_id"
    t.integer  "detail_id"
    t.string   "detail_type"
    t.integer  "parent_id"
    t.string   "parent_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by"
  end

  create_table "opportunities", :force => true do |t|
    t.string   "title"
    t.integer  "opportunity_type_id"
    t.integer  "opportunity_status_id"
    t.date     "created_effective"
    t.string   "seats"
    t.string   "experience"
    t.text     "skill_area"
    t.integer  "source_id"
    t.string   "source_type"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "source_title"
    t.integer  "user_id"
    t.date     "expiry_date"
    t.integer  "updated_by"
  end

  create_table "opportunity_statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "opportunity_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions", :force => true do |t|
    t.boolean  "can_read"
    t.boolean  "can_create"
    t.boolean  "can_edit"
    t.boolean  "can_delete"
    t.integer  "role_id"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phone_types", :force => true do |t|
    t.string   "phone_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phones", :force => true do |t|
    t.string   "phone_number"
    t.integer  "phone_type_id"
    t.integer  "phoneable_id"
    t.string   "phoneable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "placements", :force => true do |t|
    t.date     "date_effective"
    t.text     "available_resources"
    t.text     "freeing_up_resources"
    t.text     "reserved_resources"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.text     "summary"
    t.integer  "updated_by"
  end

  create_table "plugins", :force => true do |t|
    t.string   "name"
    t.boolean  "activated"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resource_billing_types", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resource_types", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resource_vteam_allocations", :force => true do |t|
    t.date     "join_date"
    t.float    "billing_rate"
    t.boolean  "active"
    t.text     "reason"
    t.date     "release_date"
    t.integer  "updated_by"
    t.string   "resource_type"
    t.integer  "vteam_id"
    t.integer  "resource_id"
    t.integer  "resource_billing_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resources", :force => true do |t|
    t.integer  "employee_id"
    t.string   "name"
    t.integer  "number"
    t.text     "experience"
    t.float    "billing_rate"
    t.integer  "updated_by"
    t.integer  "resource_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "system_resources", :force => true do |t|
    t.string   "class_name"
    t.string   "class_action"
    t.text     "description"
    t.integer  "parent_resource"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "testing", :force => true do |t|
    t.text     "primary_skills", :null => false
    t.text     "situation",      :null => false
    t.text     "original_email", :null => false
    t.integer  "company_id",     :null => false
    t.integer  "contact_id",     :null => false
    t.integer  "lead_status_id", :null => false
    t.integer  "lead_type_id",   :null => false
    t.integer  "lead_source_id", :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "title",          :null => false
    t.integer  "user_id",        :null => false
  end

  add_index "testing", ["id"], :name => "id", :unique => true

  create_table "testings", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_roles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "time_zone"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "vacation_types", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vacations", :force => true do |t|
    t.date     "from"
    t.date     "to"
    t.text     "reason"
    t.integer  "vacation_type_id"
    t.integer  "resource_vteam_allocation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vteam_statuses", :force => true do |t|
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vteams", :force => true do |t|
    t.string   "name"
    t.integer  "vteam_status_id"
    t.date     "start_date"
    t.integer  "lead_id"
    t.string   "dev_manager"
    t.string   "working_hours"
    t.integer  "dev_center_id"
    t.integer  "billing_mode_id"
    t.date     "approved_on"
    t.integer  "flag_id"
    t.text     "developers"
    t.text     "intent_to_start"
    t.text     "startup_advice"
    t.text     "technologies"
    t.text     "special_note"
    t.text     "key_dates"
    t.boolean  "updated_by_client"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "updated_by"
  end

  create_table "website_types", :force => true do |t|
    t.string   "website_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "websites", :force => true do |t|
    t.string   "url"
    t.integer  "website_type_id"
    t.integer  "websiteable_id"
    t.string   "websiteable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "xdoc_types", :force => true do |t|
    t.string   "title"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "xdocs", :force => true do |t|
    t.string   "title"
    t.integer  "xdoc_type_id"
    t.text     "detail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "xdocs_doc_types", :force => true do |t|
    t.string   "title"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
