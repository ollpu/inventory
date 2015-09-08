class AddPasswordResetTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :password_reset_token, :string
    add_column :users, :password_reset_time, :datetime
  end
end
