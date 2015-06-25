class AddLocationToUser < ActiveRecord::Migration
  def change
    add_column :users, :location, :string
    add_column :users, :image_url, :string
    add_column :users, :url, :string
  end
end
