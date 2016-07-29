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

ActiveRecord::Schema.define(version: 20160729055632) do

  create_table "admins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "job_number",         limit: 50
    t.string   "password_digest"
    t.string   "name",               limit: 50
    t.string   "permissions",        limit: 50
    t.string   "position",           limit: 50
    t.integer  "age"
    t.integer  "gender"
    t.string   "email",              limit: 50
    t.string   "phone",              limit: 50
    t.string   "address"
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.string   "current_sign_in_ip", limit: 50
    t.datetime "last_sign_in_at"
    t.string   "last_sign_in_ip",    limit: 50
    t.integer  "failed_attempts"
    t.datetime "locked_at"
    t.string   "access_token"
    t.datetime "last_activity_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["access_token"], name: "index_admins_on_access_token", unique: true, using: :btree
    t.index ["job_number"], name: "index_admins_on_job_number", unique: true, using: :btree
    t.index ["name"], name: "index_admins_on_name", using: :btree
  end

  create_table "competitions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                 limit: 50,    null: false
    t.string   "host_year",                          null: false
    t.text     "description",          limit: 65535
    t.text     "emc_contact",          limit: 65535
    t.string   "cover"
    t.text     "body_html",            limit: 65535
    t.string   "guide_units"
    t.string   "organizer_units"
    t.string   "help_units"
    t.string   "support_units"
    t.string   "undertake_units"
    t.text     "video",                limit: 65535
    t.text     "file",                 limit: 65535
    t.integer  "status",                             null: false
    t.datetime "apply_start_time"
    t.datetime "apply_end_time"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "keyword"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "time_schedule"
    t.string   "detail_rule"
    t.text     "aim",                  limit: 65535
    t.text     "organizing_committee", limit: 65535
    t.text     "date_schedule",        limit: 65535
    t.text     "apply_require",        limit: 65535
    t.text     "reward_method",        limit: 65535
    t.text     "apply_method",         limit: 65535
    t.datetime "school_audit_time",                  null: false
    t.datetime "district_audit_time",                null: false
    t.index ["district_audit_time"], name: "index_competitions_on_district_audit_time", using: :btree
    t.index ["end_time"], name: "index_competitions_on_end_time", using: :btree
    t.index ["host_year"], name: "index_competitions_on_host_year", using: :btree
    t.index ["name"], name: "index_competitions_on_name", unique: true, using: :btree
    t.index ["school_audit_time"], name: "index_competitions_on_school_audit_time", using: :btree
    t.index ["start_time"], name: "index_competitions_on_start_time", using: :btree
    t.index ["status"], name: "index_competitions_on_status", using: :btree
  end

  create_table "consults", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",                     null: false
    t.integer  "parent_id"
    t.string   "content",                     null: false
    t.boolean  "status",      default: false, null: false
    t.boolean  "unread",      default: false, null: false
    t.boolean  "admin_reply", default: false, null: false
    t.integer  "admin_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["admin_id"], name: "index_consults_on_admin_id", using: :btree
    t.index ["admin_reply"], name: "index_consults_on_admin_reply", using: :btree
    t.index ["parent_id"], name: "index_consults_on_parent_id", using: :btree
    t.index ["status"], name: "index_consults_on_status", using: :btree
    t.index ["unread"], name: "index_consults_on_unread", using: :btree
    t.index ["user_id"], name: "index_consults_on_user_id", using: :btree
  end

  create_table "course_files", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "course_id",   null: false
    t.string   "course_ware"
    t.boolean  "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["course_id"], name: "index_course_files_on_course_id", using: :btree
    t.index ["status"], name: "index_course_files_on_status", using: :btree
  end

  create_table "course_score_attributes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "course_id",  null: false
    t.string   "name",       null: false
    t.integer  "score_per",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id", "name"], name: "index_course_score_attributes", unique: true, using: :btree
    t.index ["course_id"], name: "index_course_score_attributes_on_course_id", using: :btree
    t.index ["score_per"], name: "index_course_score_attributes_on_score_per", using: :btree
  end

  create_table "course_user_scores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "course_sa_id",        null: false
    t.string   "score",               null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "course_user_ship_id"
    t.index ["course_sa_id"], name: "index_course_user_scores_on_course_sa_id", using: :btree
    t.index ["course_user_ship_id"], name: "index_course_user_scores_on_course_user_ship_id", using: :btree
  end

  create_table "course_user_ships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "course_id",              null: false
    t.integer  "user_id",                null: false
    t.integer  "status",     default: 0, null: false
    t.integer  "school_id",              null: false
    t.integer  "grade",                  null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "score"
    t.index ["course_id", "user_id"], name: "index_course_user_ships_on_course_id_and_user_id", unique: true, using: :btree
    t.index ["course_id"], name: "index_course_user_ships_on_course_id", using: :btree
    t.index ["grade"], name: "index_course_user_ships_on_grade", using: :btree
    t.index ["school_id"], name: "index_course_user_ships_on_school_id", using: :btree
    t.index ["score"], name: "index_course_user_ships_on_score", using: :btree
    t.index ["status"], name: "index_course_user_ships_on_status", using: :btree
    t.index ["user_id"], name: "index_course_user_ships_on_user_id", using: :btree
  end

  create_table "courses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                                       null: false
    t.string   "target",                                     null: false
    t.text     "desc",             limit: 65535
    t.string   "run_address",                                null: false
    t.integer  "num",                                        null: false
    t.datetime "apply_start_time",                           null: false
    t.datetime "apply_end_time",                             null: false
    t.datetime "start_time",                                 null: false
    t.datetime "end_time",                                   null: false
    t.string   "run_time",                                   null: false
    t.integer  "status",                         default: 0, null: false
    t.integer  "user_id"
    t.string   "keyword"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "district_id",                                null: false
    t.integer  "apply_count",                    default: 0, null: false
    t.index ["apply_count"], name: "index_courses_on_apply_count", using: :btree
    t.index ["apply_end_time"], name: "index_courses_on_apply_end_time", using: :btree
    t.index ["apply_start_time"], name: "index_courses_on_apply_start_time", using: :btree
    t.index ["district_id"], name: "index_courses_on_district_id", using: :btree
    t.index ["name"], name: "index_courses_on_name", unique: true, using: :btree
    t.index ["num"], name: "index_courses_on_num", using: :btree
    t.index ["status"], name: "index_courses_on_status", using: :btree
    t.index ["user_id"], name: "index_courses_on_user_id", using: :btree
  end

  create_table "districts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       limit: 30
    t.string   "city",       limit: 30
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["city"], name: "index_districts_on_city", using: :btree
    t.index ["name", "city"], name: "index_districts_on_name_and_city", unique: true, using: :btree
    t.index ["name"], name: "index_districts_on_name", using: :btree
  end

  create_table "email_codes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email"
    t.string   "code",            limit: 20
    t.string   "message_type",    limit: 30
    t.integer  "failed_attempts"
    t.string   "ip",              limit: 50
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["email"], name: "index_email_codes_on_email", using: :btree
    t.index ["ip"], name: "index_email_codes_on_ip", using: :btree
    t.index ["message_type"], name: "index_email_codes_on_message_type", using: :btree
  end

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",             limit: 60
    t.boolean  "is_father",                      default: false, null: false
    t.integer  "parent_id"
    t.integer  "competition_id"
    t.integer  "level",                          default: 1,     null: false
    t.text     "description",      limit: 65535
    t.string   "cover"
    t.text     "body_html",        limit: 65535
    t.integer  "status"
    t.text     "against",          limit: 65535
    t.integer  "timer"
    t.string   "group"
    t.integer  "team_min_num"
    t.integer  "team_max_num"
    t.datetime "apply_start_time"
    t.datetime "apply_end_time"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.index ["apply_end_time"], name: "index_events_on_apply_end_time", using: :btree
    t.index ["apply_start_time"], name: "index_events_on_apply_start_time", using: :btree
    t.index ["competition_id"], name: "index_events_on_competition_id", using: :btree
    t.index ["end_time"], name: "index_events_on_end_time", using: :btree
    t.index ["name", "competition_id", "parent_id"], name: "index_events_on_name_and_competition_id_and_parent_id", unique: true, using: :btree
    t.index ["status"], name: "index_events_on_status", using: :btree
    t.index ["team_max_num"], name: "index_events_on_team_max_num", using: :btree
    t.index ["timer"], name: "index_events_on_timer", using: :btree
  end

  create_table "mobile_codes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "mobile"
    t.string   "code",            limit: 20
    t.string   "message_type",    limit: 20
    t.integer  "failed_attempts"
    t.string   "ip",              limit: 50
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["ip"], name: "index_mobile_codes_on_ip", using: :btree
    t.index ["message_type"], name: "index_mobile_codes_on_message_type", using: :btree
    t.index ["mobile"], name: "index_mobile_codes_on_mobile", using: :btree
  end

  create_table "notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.text     "content",      limit: 65535
    t.integer  "message_type",               default: 0,     null: false
    t.integer  "team_id"
    t.integer  "t_u_id"
    t.integer  "reply_to"
    t.boolean  "read",                       default: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.index ["message_type"], name: "index_notifications_on_message_type", using: :btree
    t.index ["read"], name: "index_notifications_on_read", using: :btree
    t.index ["t_u_id"], name: "index_notifications_on_t_u_id", using: :btree
    t.index ["team_id"], name: "index_notifications_on_team_id", using: :btree
    t.index ["user_id"], name: "index_notifications_on_user_id", using: :btree
  end

  create_table "organizers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",        limit: 50
    t.integer  "category"
    t.string   "responsible"
    t.string   "tel"
    t.string   "address"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["category"], name: "index_organizers_on_category", using: :btree
    t.index ["name"], name: "index_organizers_on_name", unique: true, using: :btree
  end

  create_table "photos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "competition_id"
    t.string   "image"
    t.boolean  "status",         default: false
    t.integer  "sort"
    t.string   "desc"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["competition_id", "sort"], name: "index_photos_on_competition_id_and_sort", using: :btree
    t.index ["competition_id"], name: "index_photos_on_competition_id", using: :btree
    t.index ["sort"], name: "index_photos_on_sort", using: :btree
    t.index ["status"], name: "index_photos_on_status", using: :btree
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_roles_on_name", unique: true, using: :btree
  end

  create_table "schools", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                         null: false
    t.integer  "school_type"
    t.integer  "district_id",                  null: false
    t.boolean  "status",       default: true,  null: false
    t.boolean  "audit"
    t.boolean  "user_add",     default: false, null: false
    t.integer  "user_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "teacher_role"
    t.index ["audit"], name: "index_schools_on_audit", using: :btree
    t.index ["district_id"], name: "index_schools_on_district_id", using: :btree
    t.index ["name"], name: "index_schools_on_name", unique: true, using: :btree
    t.index ["school_type", "district_id"], name: "index_schools_on_school_type_and_district_id", using: :btree
    t.index ["school_type"], name: "index_schools_on_school_type", using: :btree
    t.index ["status"], name: "index_schools_on_status", using: :btree
    t.index ["teacher_role"], name: "index_schools_on_teacher_role", using: :btree
    t.index ["user_add"], name: "index_schools_on_user_add", using: :btree
    t.index ["user_id", "user_add", "status"], name: "index_user_add_schools", using: :btree
  end

  create_table "team_user_ships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "team_id",     null: false
    t.integer  "user_id",     null: false
    t.integer  "event_id"
    t.integer  "district_id"
    t.integer  "school_id",   null: false
    t.integer  "grade"
    t.boolean  "status"
    t.string   "num"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["district_id"], name: "index_team_user_ships_on_district_id", using: :btree
    t.index ["event_id", "team_id", "user_id"], name: "index_team_user_ships_on_event_id_and_team_id_and_user_id", unique: true, using: :btree
    t.index ["event_id", "user_id"], name: "index_team_user_ships_on_event_id_and_user_id", unique: true, using: :btree
    t.index ["event_id"], name: "index_team_user_ships_on_event_id", using: :btree
    t.index ["num"], name: "index_team_user_ships_on_num", using: :btree
    t.index ["school_id"], name: "index_team_user_ships_on_school_id", using: :btree
    t.index ["status"], name: "index_team_user_ships_on_status", using: :btree
    t.index ["team_id", "user_id"], name: "index_team_user_ships_on_team_id_and_user_id", unique: true, using: :btree
    t.index ["team_id"], name: "index_team_user_ships_on_team_id", using: :btree
    t.index ["user_id"], name: "index_team_user_ships_on_user_id", using: :btree
  end

  create_table "teams", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "group"
    t.integer  "status",                       default: 0, null: false
    t.boolean  "audit"
    t.string   "identifier"
    t.integer  "event_id",                                 null: false
    t.integer  "school_id"
    t.integer  "sk_station"
    t.integer  "school1"
    t.integer  "district_id"
    t.string   "description"
    t.string   "teacher"
    t.string   "teacher_mobile"
    t.string   "team_code",      limit: 6
    t.string   "cover"
    t.text     "score_process",  limit: 65535
    t.string   "last_score"
    t.string   "referee_id"
    t.integer  "rank"
    t.text     "note",           limit: 65535
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "players",                      default: 0, null: false
    t.index ["district_id", "event_id", "status"], name: "district_index_on_teams", using: :btree
    t.index ["district_id"], name: "index_teams_on_district_id", using: :btree
    t.index ["event_id", "user_id"], name: "index_teams_on_event_id_and_user_id", unique: true, using: :btree
    t.index ["event_id"], name: "index_teams_on_event_id", using: :btree
    t.index ["identifier"], name: "index_teams_on_identifier", unique: true, using: :btree
    t.index ["name"], name: "index_teams_on_name", using: :btree
    t.index ["players"], name: "index_teams_on_players", using: :btree
    t.index ["school_id", "event_id", "status"], name: "school_index_on_teams", using: :btree
    t.index ["status"], name: "index_teams_on_status", using: :btree
    t.index ["teacher"], name: "index_teams_on_teacher", using: :btree
    t.index ["team_code"], name: "index_teams_on_team_code", using: :btree
    t.index ["user_id"], name: "index_teams_on_user_id", using: :btree
  end

  create_table "user_profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "username"
    t.integer  "gender"
    t.integer  "age"
    t.integer  "school_id"
    t.integer  "sk_station"
    t.integer  "standby_school"
    t.string   "student_code"
    t.string   "identity_card"
    t.string   "nationality"
    t.string   "grade"
    t.integer  "bj"
    t.string   "autograph"
    t.string   "address"
    t.string   "roles"
    t.integer  "district_id"
    t.date     "birthday"
    t.string   "teacher_no"
    t.string   "certificate"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["district_id"], name: "index_user_profiles_on_district_id", using: :btree
    t.index ["gender"], name: "index_user_profiles_on_gender", using: :btree
    t.index ["grade"], name: "index_user_profiles_on_grade", using: :btree
    t.index ["identity_card"], name: "index_user_profiles_on_identity_card", using: :btree
    t.index ["roles"], name: "index_user_profiles_on_roles", using: :btree
    t.index ["school_id"], name: "index_user_profiles_on_school_id", using: :btree
    t.index ["sk_station"], name: "index_user_profiles_on_sk_station", using: :btree
    t.index ["student_code"], name: "index_user_profiles_on_student_code", using: :btree
    t.index ["user_id"], name: "index_user_profiles_on_user_id", unique: true, using: :btree
  end

  create_table "user_roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.integer  "status"
    t.integer  "role_type"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "desc",       limit: 65535
    t.string   "cover"
    t.index ["role_id"], name: "index_user_roles_on_role_id", using: :btree
    t.index ["role_type"], name: "index_user_roles_on_role_type", using: :btree
    t.index ["status"], name: "index_user_roles_on_status", using: :btree
    t.index ["user_id", "role_id", "role_type"], name: "index_user_roles_on_user_id_and_role_id_and_role_type", unique: true, using: :btree
    t.index ["user_id", "role_id"], name: "index_user_roles_on_user_id_and_role_id", using: :btree
    t.index ["user_id"], name: "index_user_roles_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "mobile"
    t.string   "nickname"
    t.string   "avatar"
    t.string   "point"
    t.integer  "status",                 default: 0,  null: false
    t.string   "private_token"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "guid"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["mobile"], name: "index_users_on_mobile", using: :btree
    t.index ["nickname"], name: "index_users_on_nickname", unique: true, using: :btree
    t.index ["private_token"], name: "index_users_on_private_token", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["status"], name: "index_users_on_status", using: :btree
  end

  create_table "videos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "competition_id"
    t.string   "video"
    t.boolean  "status",         default: false
    t.integer  "sort"
    t.string   "desc"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["competition_id", "sort"], name: "index_videos_on_competition_id_and_sort", using: :btree
    t.index ["competition_id"], name: "index_videos_on_competition_id", using: :btree
    t.index ["sort"], name: "index_videos_on_sort", using: :btree
    t.index ["status"], name: "index_videos_on_status", using: :btree
  end

end
