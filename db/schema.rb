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

ActiveRecord::Schema.define(version: 20170719213903) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "a_trinomials", force: :cascade do |t|
    t.integer  "root1"
    t.integer  "root2"
    t.string   "pattern",    default: "a_greater_one"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "special_trinomials", force: :cascade do |t|
    t.integer  "root1"
    t.integer  "root2"
    t.string   "pattern"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trinomials", force: :cascade do |t|
    t.integer  "root1"
    t.integer  "root2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "pattern"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.integer  "plus_plus_mastery",     default: 0
    t.integer  "minus_plus_mastery",    default: 0
    t.integer  "minus_minus_mastery",   default: 0
    t.integer  "plus_minus_mastery",    default: 0
    t.integer  "plus_dbl_sq_mastery",   default: 0
    t.integer  "minus_dbl_sq_mastery",  default: 0
    t.integer  "diff_sq_mastery",       default: 0
    t.integer  "prime_mastery",         default: 0
    t.integer  "a_greater_one_mastery", default: 0
    t.integer  "gcf_mastery",           default: 0
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "total_problems",        default: 0
    t.integer  "plus_plus_count",       default: 0
    t.integer  "minus_plus_count",      default: 0
    t.integer  "minus_minus_count",     default: 0
    t.integer  "plus_minus_count",      default: 0
    t.integer  "plus_dbl_sq_count",     default: 0
    t.integer  "minus_dbl_sq_count",    default: 0
    t.integer  "diff_sq_count",         default: 0
    t.integer  "prime_count",           default: 0
    t.integer  "gcf_count",             default: 0
    t.integer  "a_greater_one_count",   default: 0
    t.string   "password_hash"
  end

end
