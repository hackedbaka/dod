class AddEarnedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :earned, :float
  end
end
