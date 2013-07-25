class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.references :metric1, :null => false
      t.references :metric2, :null => false
      t.datetime :lock_time
      t.boolean :finalized
      t.timestamps
    end
  end
end
