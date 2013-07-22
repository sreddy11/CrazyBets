class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string   "first_name",  null: false
      t.string   "last_name",   null: false
      t.string   "user_name",   null: false
      t.string   "email",       null: false
      t.string   "password_digest", null: false
      t.string   "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.integer  "invitation_id"

      t.timestamps
    end
  end
end
