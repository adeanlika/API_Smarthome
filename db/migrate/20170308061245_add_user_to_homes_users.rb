class AddUserToHomesUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :homes_users, :user, foreign_key: true
  end
end
