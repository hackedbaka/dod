class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :room_id
      t.string :p1
      t.float :p1_bet
      t.string :p2
      t.float :p2_bet

      t.timestamps null: false
    end
  end
end
