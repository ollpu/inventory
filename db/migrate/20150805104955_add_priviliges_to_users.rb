class AddPriviligesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :privileges, :integer, null: :false
  end
end
