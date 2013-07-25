class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :sender_id
      t.string :recipient_email
      t.string :invite_token

      t.timestamps
    end
  end
end
