class RemoveInvitationFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :invitation_id, :integer
  end
end
