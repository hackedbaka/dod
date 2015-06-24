class AddDonatedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :donated, :float
  end
end
