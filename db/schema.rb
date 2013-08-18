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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130111085545) do

  create_table "avatars", :force => true do |t|
    t.string   "photo"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "avatars", ["user_id"], :name => "index_avatars_on_user_id"

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id",   :default => 0
    t.string   "commentable_type", :default => ""
    t.string   "title",            :default => ""
    t.text     "body"
    t.string   "subject",          :default => ""
    t.integer  "user_id",          :default => 0,  :null => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "forem_categories", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "slug"
  end

  add_index "forem_categories", ["slug"], :name => "index_forem_categories_on_slug", :unique => true

  create_table "forem_forums", :force => true do |t|
    t.string  "name"
    t.text    "description"
    t.integer "category_id"
    t.integer "views_count", :default => 0
    t.string  "slug"
  end

  add_index "forem_forums", ["slug"], :name => "index_forem_forums_on_slug", :unique => true

  create_table "forem_groups", :force => true do |t|
    t.string "name"
  end

  add_index "forem_groups", ["name"], :name => "index_forem_groups_on_name"

  create_table "forem_memberships", :force => true do |t|
    t.integer "group_id"
    t.integer "member_id"
  end

  add_index "forem_memberships", ["group_id"], :name => "index_forem_memberships_on_group_id"

  create_table "forem_moderator_groups", :force => true do |t|
    t.integer "forum_id"
    t.integer "group_id"
  end

  add_index "forem_moderator_groups", ["forum_id"], :name => "index_forem_moderator_groups_on_forum_id"

  create_table "forem_posts", :force => true do |t|
    t.integer  "topic_id"
    t.text     "text"
    t.integer  "user_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "reply_to_id"
    t.string   "state",       :default => "pending_review"
    t.boolean  "notified",    :default => false
  end

  add_index "forem_posts", ["reply_to_id"], :name => "index_forem_posts_on_reply_to_id"
  add_index "forem_posts", ["state"], :name => "index_forem_posts_on_state"
  add_index "forem_posts", ["topic_id"], :name => "index_forem_posts_on_topic_id"
  add_index "forem_posts", ["user_id"], :name => "index_forem_posts_on_user_id"

  create_table "forem_subscriptions", :force => true do |t|
    t.integer "subscriber_id"
    t.integer "topic_id"
  end

  create_table "forem_topics", :force => true do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.string   "subject"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.boolean  "locked",       :default => false,            :null => false
    t.boolean  "pinned",       :default => false
    t.boolean  "hidden",       :default => false
    t.datetime "last_post_at"
    t.string   "state",        :default => "pending_review"
    t.integer  "views_count",  :default => 0
    t.string   "slug"
  end

  add_index "forem_topics", ["forum_id"], :name => "index_forem_topics_on_forum_id"
  add_index "forem_topics", ["slug"], :name => "index_forem_topics_on_slug", :unique => true
  add_index "forem_topics", ["state"], :name => "index_forem_topics_on_state"
  add_index "forem_topics", ["user_id"], :name => "index_forem_topics_on_user_id"

  create_table "forem_views", :force => true do |t|
    t.integer  "user_id"
    t.integer  "viewable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count",             :default => 0
    t.string   "viewable_type"
    t.datetime "current_viewed_at"
    t.datetime "past_viewed_at"
  end

  add_index "forem_views", ["updated_at"], :name => "index_forem_views_on_updated_at"
  add_index "forem_views", ["user_id"], :name => "index_forem_views_on_user_id"
  add_index "forem_views", ["viewable_id"], :name => "index_forem_views_on_topic_id"

  create_table "messages", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.boolean  "sender_deleted",    :default => false
    t.boolean  "recipient_deleted", :default => false
    t.string   "subject"
    t.text     "body"
    t.datetime "read_at"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "thread"
  end

  add_index "messages", ["thread"], :name => "index_messages_on_thread"

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "head"
    t.text     "body",       :limit => 16777215
    t.string   "slug_md5"
    t.string   "slug"
    t.integer  "user_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "ancestry"
  end

  add_index "pages", ["ancestry"], :name => "index_pages_on_ancestry"
  add_index "pages", ["slug_md5"], :name => "index_pages_on_slug_md5"

  create_table "place_photos", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "photo"
    t.integer  "place_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.date     "photo_at"
    t.integer  "user_id"
    t.boolean  "need_ocr",       :default => false
    t.integer  "soldiers_count", :default => 0
  end

  add_index "place_photos", ["need_ocr"], :name => "index_place_photos_on_need_ocr"
  add_index "place_photos", ["place_id"], :name => "index_place_photos_on_place_id"
  add_index "place_photos", ["user_id"], :name => "index_place_photos_on_user_id"

  create_table "places", :force => true do |t|
    t.float    "lat"
    t.float    "lng"
    t.string   "title"
    t.string   "name"
    t.string   "address"
    t.string   "status"
    t.text     "description"
    t.string   "type"
    t.boolean  "is_around"
    t.string   "kind"
    t.integer  "zoom"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "ancestry"
    t.integer  "user_id"
    t.integer  "place_photos_count"
    t.integer  "soldiers_count"
    t.string   "address_path"
    t.integer  "childrens_count",    :default => 0
    t.integer  "ancestry_depth",     :default => 0
    t.boolean  "bural_place"
  end

  add_index "places", ["address"], :name => "index_places_on_address"
  add_index "places", ["address_path"], :name => "index_places_on_address_path"
  add_index "places", ["ancestry"], :name => "index_places_on_ancestry"
  add_index "places", ["kind"], :name => "index_places_on_kind"
  add_index "places", ["lat"], :name => "index_places_on_lat"
  add_index "places", ["lng"], :name => "index_places_on_lng"
  add_index "places", ["name"], :name => "index_places_on_name"
  add_index "places", ["place_photos_count"], :name => "index_places_on_place_photos_count"
  add_index "places", ["soldiers_count"], :name => "index_places_on_soldiers_count"
  add_index "places", ["type"], :name => "index_places_on_type"
  add_index "places", ["user_id"], :name => "index_places_on_user_id"

  create_table "profiles", :force => true do |t|
    t.string   "fio"
    t.text     "about"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id"

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "roles", :force => true do |t|
    t.string "name"
    t.string "title"
  end

  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "soldiers", :force => true do |t|
    t.string   "fio"
    t.string   "name1"
    t.string   "name2"
    t.string   "name3"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "place_id"
    t.integer  "user_id"
    t.integer  "soldirable_id"
    t.string   "soldirable_type", :limit => 32
  end

  add_index "soldiers", ["place_id"], :name => "index_soldiers_on_place_id"
  add_index "soldiers", ["soldirable_id"], :name => "index_soldiers_on_soldirable_id"
  add_index "soldiers", ["soldirable_type"], :name => "index_soldiers_on_soldirable_type"
  add_index "soldiers", ["user_id"], :name => "index_soldiers_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",         :null => false
    t.string   "encrypted_password",     :default => "",         :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.string   "nick"
    t.boolean  "forem_admin",            :default => false
    t.string   "forem_state",            :default => "approved"
    t.boolean  "forem_auto_subscribe",   :default => false
    t.string   "provider"
    t.string   "uid"
    t.integer  "soldiers_count",         :default => 0
    t.integer  "place_photos_count",     :default => 0
    t.integer  "places_count",           :default => 0
    t.integer  "comments_count",         :default => 0
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
