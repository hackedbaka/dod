class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :category
      t.string :text
      t.string :answer_1
      t.string :answer_2
      t.string :answer_3
      t.string :answer_4
      t.integer :correct_answer
      add_reference :questions, :games_id
      
      t.timestamps null: false
    end
  end
end
