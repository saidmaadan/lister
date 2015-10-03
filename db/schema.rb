# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151003013815) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "amenities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blogs", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "blogs", ["slug"], name: "index_blogs_on_slug", unique: true, using: :btree
  add_index "blogs", ["user_id", "created_at"], name: "index_blogs_on_user_id_and_created_at", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categorizations", force: true do |t|
    t.integer  "listing_id"
    t.integer  "amenity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categorizations", ["amenity_id"], name: "index_categorizations_on_amenity_id", using: :btree
  add_index "categorizations", ["listing_id"], name: "index_categorizations_on_listing_id", using: :btree

  create_table "enquiries", force: true do |t|
    t.text     "comment"
    t.integer  "listing_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "enquiries", ["listing_id"], name: "index_enquiries_on_listing_id", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "likes", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "listings", force: true do |t|
    t.string   "home_type"
    t.decimal  "accomodate"
    t.decimal  "pricing"
    t.string   "title"
    t.text     "summary"
    t.string   "apartment_type"
    t.decimal  "bedroom"
    t.decimal  "bathroom"
    t.string   "contact_name"
    t.string   "company_name"
    t.string   "phone"
    t.string   "website_url"
    t.string   "user_type"
    t.text     "info"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "listings_file_name"
    t.string   "listings_content_type"
    t.integer  "listings_file_size"
    t.datetime "listings_updated_at"
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
    t.integer  "user_id"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "slug"
  end

  add_index "listings", ["slug"], name: "index_listings_on_slug", unique: true, using: :btree

  create_table "reviews", force: true do |t|
    t.integer  "stars"
    t.text     "comment"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "users_file_name"
    t.string   "users_content_type"
    t.integer  "users_file_size"
    t.datetime "users_updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "admin",               default: false
    t.string   "sex"
    t.datetime "birthdate"
    t.string   "phone_number"
    t.string   "where_you_live"
    t.text     "info"
    t.string   "school"
    t.string   "work"
    t.string   "marital_status"
    t.string   "video"
    t.string   "slug"
  end

  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree

end
