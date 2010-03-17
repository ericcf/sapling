# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100316210929) do

  create_table "addresses", :force => true do |t|
    t.string   "street"
    t.string   "line_two"
    t.string   "city"
    t.string   "state"
    t.integer  "zip_code"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chunks", :force => true do |t|
    t.string   "name"
    t.text     "text"
    t.integer  "section_id"
    t.integer  "section_index"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "configuration", :force => true do |t|
    t.string "classname"
    t.text   "object"
  end

  create_table "content_actions", :force => true do |t|
    t.string   "content_type"
    t.integer  "content_id"
    t.integer  "user_id"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "content_actions", ["content_type", "content_id"], :name => "index_content_actions_on_content_type_and_content_id"
  add_index "content_actions", ["user_id"], :name => "index_content_actions_on_user_id"

  create_table "content_workflow_states", :force => true do |t|
    t.string   "content_type"
    t.integer  "content_id"
    t.integer  "workflow_state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "slug"
    t.string   "title"
    t.text     "text"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "google_maps", :force => true do |t|
    t.string   "slug"
    t.string   "title"
    t.float    "center_lat"
    t.float    "center_lon"
    t.integer  "zoom_level"
    t.string   "map_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string "name"
  end

  add_index "groups", ["name"], :name => "index_groups_on_name", :unique => true

  create_table "map_pins", :force => true do |t|
    t.integer  "map_id"
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "marquees", :force => true do |t|
    t.string   "slug"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news_items", :force => true do |t|
    t.string   "slug"
    t.string   "title"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "text"
    t.integer  "author_id"
    t.string   "external_uri"
    t.datetime "publish_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nodes", :force => true do |t|
    t.text     "path"
    t.integer  "parent_id"
    t.integer  "content_id"
    t.string   "content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nodes", ["content_id", "content_type"], :name => "index_nodes_on_content_id_and_content_type", :unique => true
  add_index "nodes", ["parent_id"], :name => "index_nodes_on_parent_id"
  add_index "nodes", ["path"], :name => "index_nodes_on_path", :unique => true

  create_table "pages", :force => true do |t|
    t.string   "slug"
    t.string   "title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rights", :force => true do |t|
    t.string "name"
    t.string "controller"
    t.string "action"
  end

  create_table "role_assignments", :force => true do |t|
    t.integer "role_id"
    t.integer "entity_id"
    t.string  "entity_type"
  end

  add_index "role_assignments", ["entity_id", "entity_type"], :name => "index_role_assignments_on_entity_id_and_entity_type"
  add_index "role_assignments", ["role_id", "entity_id", "entity_type"], :name => "index_role_assignments_on_role_id_and_entity_id_and_entity_type", :unique => true

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  add_index "roles", ["name"], :name => "index_roles_on_name", :unique => true

  create_table "sections", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shared_emails", :force => true do |t|
    t.string   "recipient"
    t.string   "sender"
    t.integer  "content_id"
    t.string   "content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slides", :force => true do |t|
    t.string   "slug"
    t.string   "title"
    t.text     "text"
    t.integer  "target_id"
    t.string   "target_type"
    t.integer  "marquee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stateful_rights", :force => true do |t|
    t.integer "right_id"
    t.integer "role_id"
    t.integer "workflow_state_id"
  end

  add_index "stateful_rights", ["right_id", "role_id", "workflow_state_id"], :name => "index_stateful_rights_on_right_id_and_role_id_and_workflow_state_id", :unique => true

  create_table "tag_associations", :force => true do |t|
    t.integer  "tag_id"
    t.string   "content_type"
    t.integer  "content_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tag_associations", ["content_type", "content_id"], :name => "index_tag_associations_on_content_type_and_content_id"
  add_index "tag_associations", ["tag_id"], :name => "index_tag_associations_on_tag_id"

  create_table "tag_collections", :force => true do |t|
    t.string   "label"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "label"
    t.integer  "parent_id"
    t.integer  "tag_collection_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["tag_collection_id"], :name => "index_tags_on_tag_collection_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password_salt"
    t.string   "password_hash"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "workflow_states", :force => true do |t|
    t.string  "name"
    t.boolean "is_default"
  end

  add_index "workflow_states", ["name"], :name => "index_workflow_states_on_name", :unique => true

  create_table "workflow_transitions", :force => true do |t|
    t.integer  "before_state_id"
    t.integer  "after_state_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "workflow_triggers", :force => true do |t|
    t.string   "type"
    t.integer  "content_workflow_state_id"
    t.integer  "target_state_id"
    t.datetime "activate_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workflow_triggers", ["content_workflow_state_id"], :name => "index_workflow_triggers_on_content_workflow_state_id"
  add_index "workflow_triggers", ["target_state_id"], :name => "index_workflow_triggers_on_target_state_id"

end
