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

ActiveRecord::Schema.define(version: 20170714191611) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "special_trinomials", force: :cascade do |t|
    t.integer  "root1"
    t.integer  "root2"
    t.string   "pattern"
    t.boolean  "solution_submitted", default: false
    t.integer  "user_id",            default: 1
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["user_id"], name: "index_special_trinomials_on_user_id", using: :btree
  end

  create_table "trinomials", force: :cascade do |t|
    t.integer  "root1"
    t.integer  "root2"
    t.boolean  "solution_submitted", default: false
    t.integer  "user_id",            default: 1
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "pattern"
    t.index ["user_id"], name: "index_trinomials_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.integer  "mastery_plus_plus",      default: 0
    t.integer  "mastery_minus_plus",     default: 0
    t.integer  "mastery_minus_minus",    default: 0
    t.integer  "mastery_plus_minus",     default: 0
    t.integer  "mastery_plus_dbl_sq",    default: 0
    t.integer  "mastery_minus_dbl_sq",   default: 0
    t.integer  "mastery_diff_sq",        default: 0
    t.integer  "mastery_prime",          default: 0
    t.integer  "mastery_ones_and_zeros", default: 0
    t.integer  "mastery_gcf",            default: 0
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "total_problems",         default: 0
  end

end
