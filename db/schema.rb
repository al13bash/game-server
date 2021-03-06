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

ActiveRecord::Schema.define(version: 20161010084402) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "amount_cents",    default: 0,     null: false
    t.string   "amount_currency", default: "EUR", null: false
    t.index ["user_id"], name: "index_accounts_on_user_id", using: :btree
  end

  create_table "app_errors", force: :cascade do |t|
    t.string   "kind"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "currency_exchanges", force: :cascade do |t|
    t.decimal  "usd"
    t.decimal  "rub"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_errors", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "app_error_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["app_error_id"], name: "index_game_errors_on_app_error_id", using: :btree
    t.index ["game_id"], name: "index_game_errors_on_game_id", using: :btree
  end

  create_table "game_services", force: :cascade do |t|
    t.integer  "revenue_amount_cents",    default: 0,     null: false
    t.string   "revenue_amount_currency", default: "EUR", null: false
    t.integer  "min_bet_amount_cents",    default: 1000
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "games", id: :bigserial, force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.datetime "finished_at"
    t.string   "status"
    t.integer  "bet_amount_cents",    default: 0,     null: false
    t.string   "bet_amount_currency", default: "EUR", null: false
    t.integer  "win_amount_cents",    default: 0,     null: false
    t.string   "win_amount_currency", default: "EUR", null: false
    t.integer  "account_id"
    t.integer  "validations_count"
    t.index ["account_id"], name: "index_games_on_account_id", using: :btree
    t.index ["user_id"], name: "index_games_on_user_id", using: :btree
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "score_cents",    default: 0,     null: false
    t.string   "score_currency", default: "EUR", null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["game_id"], name: "index_ratings_on_game_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username",                            null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  add_foreign_key "game_errors", "app_errors"
  add_foreign_key "game_errors", "games"
end
