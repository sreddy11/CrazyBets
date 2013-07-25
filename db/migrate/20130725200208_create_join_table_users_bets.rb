class CreateJoinTableUsersBets < ActiveRecord::Migration
  def change
    create_join_table :users, :bets do |t|
      t.index :user_id
      t.index :bet_id
      t.string :result
    end
  end
end
