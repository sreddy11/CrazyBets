class CreateMetrics < ActiveRecord::Migration
  def change
    create_table :metrics do |t|
      t.text :topic
      t.string :source
      t.timestamps
    end
  end
end
